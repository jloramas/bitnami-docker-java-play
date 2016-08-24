FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

USER root

# Install extra packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && apt-get -y install openjdk-8-jdk && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Java/Play (Activator) module
RUN bitnami-pkg install activator-1.3.10-0 --checksum cb7da7398f22782c308fcfa0959c3b8b23eb7138247e343bd207ae06601fdd1b

# Java/Play template
ENV BITNAMI_APP_NAME=play-che \
    BITNAMI_IMAGE_VERSION=

EXPOSE 9000
WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

CMD ["tail", "-f", "/dev/null"]