FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

USER root

# Install extra packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install related packages
RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773
ENV PATH=/opt/bitnami/java/bin:$PATH

RUN bitnami-pkg install python-2.7.12rc1-0 --checksum 2c56021761411358b949fa0c962d61875d70f5b092fc937dceea1b52ce8440d5
ENV PATH=/opt/bitnami/python/bin:$PATH

# Swift module
RUN bitnami-pkg install swift-3.0-PREVIEW-6-0 --checksum 36e3739c1a22bec70a4f256ff82aab10fc1996f89d85a050fe6b9cb072b3fb94
ENV PATH=/opt/bitnami/swift/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Swift template
ENV BITNAMI_APP_NAME=swift-che \
    BITNAMI_IMAGE_VERSION=3.0-PREVIEW-6

EXPOSE 80
WORKDIR /projects

# Interact with Eclipse che
LABEL che:server:80:ref=swift che:server:80:protocol=http

CMD ["tail", "-f", "/dev/null"]
