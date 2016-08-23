FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

USER root

# Install extra packages
RUN apt-get update && \
    apt-get install -y xxx && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install related packages


# Java/Play (Activator) module


# Java/Play template

EXPOSE 80
WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:80:ref=swift che:server:80:protocol=http

CMD ["tail", "-f", "/dev/null"]
