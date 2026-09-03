#!/usr/bin/env bash
#
# Vendors the eclipse-temurin build steps for a given Java major version and
# JVM type (jdk/jre) from adoptium/containers and combines them with our own
# image customizations (temurin/Dockerfile.footer) into a build-ready
# Dockerfile in the given context directory.
#
# Usage: generate-temurin-dockerfile.sh <java-major-version> <jdk|jre> <context-dir>

set -euo pipefail

JAVA_MAJOR_VERSION="$1"
JVM_TYPE="$2"
CONTEXT_DIR="$3"

ADOPTIUM_CONTAINERS_REF="${ADOPTIUM_CONTAINERS_REF:-main}"
UPSTREAM_PATH="${JAVA_MAJOR_VERSION}/${JVM_TYPE}/ubuntu/resolute/Dockerfile"
UPSTREAM_URL="https://raw.githubusercontent.com/adoptium/containers/${ADOPTIUM_CONTAINERS_REF}/${UPSTREAM_PATH}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

upstream_dockerfile="$(mktemp)"
trap 'rm -f "${upstream_dockerfile}"' EXIT

curl -fsSL --retry 3 "${UPSTREAM_URL}" -o "${upstream_dockerfile}"

if ! grep -q '^COPY --chmod=755 entrypoint\.sh' "${upstream_dockerfile}"; then
  echo "ERROR: anchor line 'COPY --chmod=755 entrypoint.sh' not found in ${UPSTREAM_URL}; upstream format may have changed, refusing to generate" >&2
  exit 1
fi

{
  echo "# Eclipse Temurin ${JAVA_MAJOR_VERSION} (${JVM_TYPE}) build steps, vendored at build time from:"
  echo "# https://github.com/adoptium/containers/blob/${ADOPTIUM_CONTAINERS_REF}/${UPSTREAM_PATH}"
  echo "# Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0)"
  echo
  sed -n '/^FROM /,/^COPY --chmod=755 entrypoint\.sh/p' "${upstream_dockerfile}" | sed '$d'
  echo
  cat "${REPO_ROOT}/temurin/Dockerfile.footer"
} > "${CONTEXT_DIR}/Dockerfile"

echo "Generated ${CONTEXT_DIR}/Dockerfile from ${UPSTREAM_URL}" >&2
