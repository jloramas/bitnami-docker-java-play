## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami-bitnami-docker-javaplay .
##
## RUNNING
##   $ docker run -p 80:80 bitnami-bitnami-docker-javaplay
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:80
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

# Java/Play module



# Java/Play template

COPY rootfs/ /

USER bitnami

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["xxx", "app", "start"]
