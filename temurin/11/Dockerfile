ARG JVM_TYPE=jre
ARG JAVA_VERSION=11.0.18_10
ARG TEMURIN_VERSION=${JAVA_VERSION}-${JVM_TYPE}-jammy
FROM eclipse-temurin:${TEMURIN_VERSION}

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        coreutils \
        fontconfig \
        fonts-dejavu && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    groupadd -g 1000 formcentric && \
    useradd -u 1000 -d /formcentric -g formcentric formcentric

USER formcentric:formcentric

WORKDIR /formcentric

COPY --chown=formcentric:formcentric run.sh .
RUN chmod +x run.sh

COPY --chown=formcentric:formcentric app.jar app.jar

ENTRYPOINT ["./run.sh"]
