# Eclipse Che Developer Workspace
You can use this Development environment to create an Eclipse Che on-demand workspace with a sample project ready to start developing. Click the link below to automatically create and launch a Swift environment workspace on Codenvy: 

[![Contribute](http://beta.codenvy.com/factory/resources/codenvy-contribute.svg)](https://beta.codenvy.com/f/?url=https%3A%2F%2Fgithub.com%2Fjuan131%2Fbitnami-docker-swift%2Ftree%2Fche)

You can find more information about Eclipse Che workspaces at the [Eclipse Che Official Documentation](https://eclipse-che.readme.io/docs/introduction)

If you are note interested on Eclipse Che on-demand workspaces, you can skip this step and follow the documentation below.

# Swift Application Development using Bitnami Docker Images

We increasingly see developers adopting two strategies for development. Using a so called “micro services” architecture and using containers for development. At Bitnami, we have developed tools and assets that dramatically lowers the overhead for developing with this approach.

If you’ve never tried to start a project with containers before, or you have tried it and found the advice, tools, and documentation to be chaotic, out of date, or wrong, then this tutorial may be for you.

In this tutorial we walk you through using the Bitnami docker images during the development lifecycle of a Swift application.

# Why Docker?

We think developers are adopting containers for development because they offer many of the same advantages as developing in VMs, but with lower overhead in terms of developer effort and development machine resources. With Docker, you can create a development environment for your code, and teammates can pull the whole development environment, install it, and quickly get started writing code or fixing bugs.

Docker development environments are more likely to be reproducible than VMs because the definition of each container and how to build it is captured in a Dockerfile.

Docker also has a well known and standard API so tools and cloud services are readily available for docker containers.

# The Bitnami Approach

When we designed and built our development containers, we kept the following guiding principles in mind:

1. Infrastructure should be effort free. By this, we mean, there are certain services in an application that are merely configured. For example, databases and web servers are essential parts of an application, but developers should depend on them like plumbing. They should be there ready to use, but developers should not be forced to waste time and effort creating the plumbing.

2. Production deployment is a late bound decision. Containers are great for development. Sometimes they are great for production, sometimes they are not. If you choose to get started with Bitnami containers for development, it is an easy matter to decide later between monolithic and services architectures, between VMs and Containers, between Cloud and bare metal deployment. This is because Bitnami builds containers specifically with flexibility of production deployment in mind. We ensure that a service running in an immutable and well tested container will behave precisely the same as the same service running in a VM or bare metal.

# Assumptions

First, we assume that you have the following components properly setup:

- [Docker Engine](https://www.docker.com/products/docker-engine)
- [Docker Compose](https://www.docker.com/products/docker-compose)
- [Docker Machine](https://www.docker.com/products/docker-machine)

> The [Docker documentation](https://docs.docker.com/) walks you through installing each of these components.

We also assume that you have some beginner-level experience using these tools.

> **Note**:
>
> If your host OS is Linux you may skip setting up Docker Machine since you'll be able to launch the containers directly in the host OS environment.

Further, we also assume that your application will be using a database. In fact, we assume that it will be using MongoDB. Of course, for a real project you may be using a different database, or, in fact, no database. But, this is a common set up and will help you learn the development approach.

## Download the Bitnami Orchestration File for Express development

We assume that you're starting the development of the [Swift](https://swift.org/) application from scratch. So lets begin by creating a directory for the application source where we'll be bootstrapping a Swift application:

```bash
$ mkdir ~/workdir/my-app
$ cd ~/workdir/my-app
```

Next, download our Docker Compose orchestration file for Swift development:

```bash
$ curl -L "https://raw.githubusercontent.com/juan131/bitnami-docker-swift/master/docker-compose.yml" > docker-compose.yml
```

> We encourage you to take a look at the contents of the orchestration file to get an idea of the services that will be started for Swift development.

## Run

Lets put the orchestration file to the test:

```bash
$ docker-compose up
```

This command reads the contents of the orchestration file and begins downloading the Docker images required to launch each of the services listed therein. Depending on the network speeds this can take anywhere from a few seconds to a couple minutes.

After the images have been downloaded, each of the services listed in the orchestration file is started, which in this case is `myapp`.

The service starts `myapp` and uses the Bitnami Swift development image. The service mounts the current working directory (`~/workdir/myapp`) at the `/app` location in the container and provides all the necessary infrastucture to get you started developing a data-driven Swift application.

This Docker Image assumes that in case you decide to deploy a web application written in Swift, the web server will be listening in the port `80`. If you want to use any other port, you will need to modify both the Dockerfile and the docker-compose.yml files as described below:

Dockefile:

~~EXPOSE 80~~
EXPOSE NEWPORT

docker-compose.yml:

~~80:80~~
NEWPORT:NEWPORT

Lets inspect the contents of the `~/workdir/myapp` directory:

```bash
~/workdir/myapp # ls
LICENSE  Packages  Package.swift  README.md  Sources
```

You can see that we have a new Swift application bootstrapped in the `~/workdir/myapp` directory of the host.

Since the application source resides on the host, you can use your favourite IDE for developing the application. Only the execution of the application occurs inside the isolated container environment.

That’s all there is to it. Without actually installing a single Swift component on the host you have a completely isolated and highly reproducible Swift development environment which can be shared with the rest of the team to get them started building the next big feature without worrying about the plumbing involved in setting up the development environment. Let Bitnami do that for you.

In the next sections we take a look at some of the common tasks that are involved during the development of a Swift application and how we go about executing those tasks.

## Executing commands

You may recall that we've not installed a single Swift component on the host and that the entire development environment is running inside the `myapp` service container. This means that if we wanted to execute [SWIFT-PACKAGE](https://swift.org/) or any other Swift command, we'd have to execute it inside the container.

This may sound like a complex task to achieve. But don't worry, Docker Compose makes it very simple to execute tasks inside a service container using the `run` command. The general form of the command looks something like the following:

```bash
$ docker-compose run <service> <command>
```

This instructs Docker Compose to execute the command specified by `<command>` inside the service container specified by `<service>`. The return value of the `docker-compose` command will reflect that of the specified command.

To see the Swift version currently installed:

```bash
$ docker-compose run myapp swift --version
```

You get the idea..

Then you can develop your swift code and when your app is ready to be build you can execute:

```bash
$ docker-compose run myapp swift build
```

Finally you can execute your app:

```bash
$ docker-compose run myapp .build/debug/yourapp
```

Thats it!
