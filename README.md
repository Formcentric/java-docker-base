# Formcentric Java Base Images

This repository contains the Dockerfiles and GitHub workflows to build the Formcentric Java Base images.
The images are the starting point to run Java-based Formcentric applications in containers.

## Usage

### Quickstart

The base image contains a simple `app.jar` to demonstrate the default entrypoint.

Running the image without any arguments:

```
> docker run ghcr.io/formcentric/java-base:21-jre

Welcome to the Formcentric Java Base image.

  Java Version  : 21.0.6 (Eclipse Adoptium)
  Java Home     : /opt/java/openjdk
  Java Temp Dir : /tmp

  User Name     : formcentric
  Working Dir   : /formcentric
  OS            : Linux 6.11.0-18-generic
  Architecture  : amd64

JVM Arguments
  (1) -XX:-UsePerfData
  (2) -XX:+UseContainerSupport
  (3) -Djava.security.egd=file:/dev/./urandom

Command Line Arguments
  - none -
```

Passing JVM and command line arguments:

```
> docker run -e JAVA_OPTS=-Djava.io.tmpdir=/my-tmp ghcr.io/formcentric/java-base:21-jre --server.port=8443

Welcome to the Formcentric Java Base image.

  Java Version  : 21.0.6 (Eclipse Adoptium)
  Java Home     : /opt/java/openjdk
  Java Temp Dir : /my-tmp

  User Name     : formcentric
  Working Dir   : /formcentric
  OS            : Linux 6.11.0-18-generic
  Architecture  : amd64

JVM Arguments
  (1) -XX:-UsePerfData
  (2) -Djava.io.tmpdir=/my-tmp
  (3) -XX:+UseContainerSupport
  (4) -Djava.security.egd=file:/dev/./urandom

Command Line Arguments
  (1) --server.port=8443
```

### Custom image

To run your own application with the base image, just overwrite the default `/formcentric/app.jar` in your
own Dockerfile:

```Dockerfile
FROM ghcr.io/formcentric/java-base:17-jre

EXPOSE 8080

COPY --chown=formcentric:formcentric my-application.jar /formcentric/app.jar
```

## Images

Formcentric base images build upon the official [Adoptium](https://adoptium.net) images of the Eclipse Temurin
distribution (OpenJDK) and come in the following flavors:

### Java 24 (Until 16 Sep 2025)

- `ghcr.io/formcentric/java-base:24-jre`
- `ghcr.io/formcentric/java-base:24-jdk`

### Java 21

- `ghcr.io/formcentric/java-base:21-jre`
- `ghcr.io/formcentric/java-base:21-jdk`

### Java 17

- `ghcr.io/formcentric/java-base:17-jre`
- `ghcr.io/formcentric/java-base:17-jdk`

### Java 11

- `ghcr.io/formcentric/java-base:11-jre`
- `ghcr.io/formcentric/java-base:11-jdk`
