---
title: Docker ps formatting
layout: post
---

At [work](https://unionmetrics.com) we've been using Docker for a minute now to
help with our development environments and it's been pretty rad so far.

A neat little trick I recently learned was how to customize `docker ps`
output.  By default, it's a little wide and noisy for my tastes:

    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                         NAMES
    fb0dabd44605        67e9ad19dc79        "/entrypoint.sh mysql"   15 minutes ago      Up About a minute   3306/tcp                                      core-mysql.dev
    db6374029e36        38ef04bdb4c4        "/opt/zookeeper/bin/z"   17 minutes ago      Up 3 minutes        2888/tcp, 0.0.0.0:2181->2181/tcp, 3888/tcp    zookeeper.dev

Not terrible, but there's some stuff in here I'm not super interested in all the
time, and I'm old and cranky and like my terminals a bit on the small-side.

> Enter The --format

Thankfully, someone made it super easy to configure the output from `docker ps`:

{% raw %}
    $ docker ps --format="table {{.Names}}\t{{.Ports}}\t{{.Status}}"
    NAMES               PORTS                                        STATUS
    core-mysql.dev      3306/tcp                                     Up 10 minutes
    zookeeper.dev       2888/tcp, 0.0.0.0:2181->2181/tcp, 3888/tcp   Up 12 minutes
{% endraw %}

Sweet, right?  Even nicer, you can add it to your docker config so you'll never
have to worry about it again:

{% raw %}
    $ cat ~/.docker/config.json
    {
      "psFormat": "table {{.Names}}\t{{.Ports}}\t{{.Status}}"
    }
{% endraw %}

Which, finally, gives you:

    $ docker ps
    NAMES               PORTS                                        STATUS
    core-mysql.dev      3306/tcp                                     Up 10 minutes
    zookeeper.dev       2888/tcp, 0.0.0.0:2181->2181/tcp, 3888/tcp   Up 12 minutes

The full list of formatting options are laid out nicely at
[https://docs.docker.com/engine/reference/commandline/ps](https://docs.docker.com/engine/reference/commandline/ps)
