#!/bin/sh
set -e

if [ -n "${EXTRA_JAVA_OPTS}" ]; then
  JAVA_OPTS="$JAVA_OPTS $EXTRA_JAVA_OPTS"
fi

JAVA_CMD_ARGS="-XX:-UsePerfData \
               ${JAVA_OPTS} \
               -XX:+UseContainerSupport \
               -Djava.security.egd=file:/dev/./urandom"

if [ -f BOOT-INF/layers.idx ]; then
  exec java $JAVA_CMD_ARGS ${SPRING_BOOT_EXPLODED_MAINCLASS:-org.springframework.boot.loader.JarLauncher} ${@}
else
  exec java $JAVA_CMD_ARGS -jar app.jar ${@}
fi
