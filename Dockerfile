# Operaton version configuration
ARG OPERATON_VERSION=2.2.0
ARG JAVA_VERSION=25

# Operaton base image - https://hub.docker.com/r/operaton/operaton
FROM operaton/operaton:${OPERATON_VERSION}-jdk${JAVA_VERSION}

LABEL org.opencontainers.image.title="Operaton w Keycloak Extension"
LABEL org.opencontainers.image.description="Operaton with the Keycloak authentication extension"
LABEL org.opencontainers.image.version="${OPERATON_VERSION}"
LABEL org.opencontainers.image.base.name="operaton/operaton:${OPERATON_VERSION}-jdk${JAVA_VERSION}"

RUN mkdir -p /operaton/configuration/userlib

# Operaton Keycloak Extension - https://github.com/operaton/operaton-keycloak
RUN wget https://repo1.maven.org/maven2/org/operaton/bpm/extension/operaton-keycloak-run/${OPERATON_VERSION}/operaton-keycloak-run-${OPERATON_VERSION}.jar -P /operaton/configuration/userlib

RUN ls -l /operaton/configuration/userlib

RUN rm -f /operaton/configuration/default.yml
RUN rm -f /operaton/configuration/deployment.yml
RUN rm -f /operaton/configuration/production.yml

COPY --chown=operaton:operaton files/keycloak-plugin/production.yml /operaton/configuration/

RUN chown -R operaton:operaton /operaton/configuration/userlib
