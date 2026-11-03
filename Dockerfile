# Operaton version configuration
ARG OPERATON_VERSION=2.2.0
ARG JAVA_VERSION=25

# Operaton base image - https://hub.docker.com/r/operaton/operaton
FROM operaton/operaton:${OPERATON_VERSION}-jdk${JAVA_VERSION}

RUN mkdir -p /operaton/configuration/userlib

# Operaton Keycloak Identity Provider Plugin version configuration
ARG KEYCLOAK_EXTENSION_VERSION=2.2.0

# Operaton Keycloak Extension - https://github.com/operaton/operaton-keycloak
RUN wget https://repo1.maven.org/maven2/org/operaton/bpm/extension/operaton-keycloak-run/${KEYCLOAK_EXTENSION_VERSION}/operaton-keycloak-run-${KEYCLOAK_EXTENSION_VERSION}.jar -P /operaton/configuration/userlib

RUN ls -l /operaton/configuration/userlib

RUN rm -f /operaton/configuration/default.yml
RUN rm -f /operaton/configuration/deployment.yml
RUN rm -f /operaton/configuration/production.yml

COPY --chown=operaton:operaton files/keycloak-plugin/production.yml /operaton/configuration/

RUN chown -R operaton:operaton /operaton/configuration/userlib
