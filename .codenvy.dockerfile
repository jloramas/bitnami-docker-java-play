FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

USER root

# Install extra packages
RUN apt-get update && \
    apt-get install -y openjdk && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Java/Play (Activator) module
RUN bitnami-pkg install 

# Java/Play template
ENV BITNAMI_APP_NAME=play-che \
    BITNAMI_IMAGE_VERSION=

EXPOSE 9000
WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:9000:ref=play che:server:9000:protocol=http

CMD ["tail", "-f", "/dev/null"]