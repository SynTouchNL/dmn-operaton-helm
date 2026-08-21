
# Operaton base image - https://hub.docker.com/r/operaton/operaton
FROM operaton/operaton:2.1.4

RUN mkdir -p /operaton/configuration/userlib

# Operaton Keycloak Extension - https://github.com/operaton/operaton-keycloak
RUN wget https://repo1.maven.org/maven2/org/operaton/bpm/extension/operaton-keycloak/1.0.0/operaton-keycloak-1.0.0.jar -P /operaton/configuration/userlib

RUN ls -l /operaton/configuration/userlib

RUN rm -f /operaton/configuration/default.yml
RUN rm -f /operaton/configuration/deployment.yml
RUN rm -f /operaton/configuration/production.yml

COPY --chown=operaton:operaton examples/production.yml /operaton/configuration/

RUN chown -R operaton:operaton /operaton/configuration/userlib
