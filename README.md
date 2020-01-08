# CentOS8 Ansible Test Image

<a href="https://github.com/MonolithProjects/docker-systemd-centos8/actions"><img src="https://github.com/MonolithProjects/docker-systemd-centos8/workflows/Dockerfile%20test/badge.svg?branch=master"/></a>
<a href="https://hub.docker.com/repository/docker/monolithprojects/systemd-centos8"><img src="https://img.shields.io/microbadger/image-size/monolithprojects/systemd-centos8/master"/></a>
<a href="https://hub.docker.com/repository/docker/monolithprojects/systemd-centos8"><img src="https://img.shields.io/docker/pulls/monolithprojects/systemd-centos8"/></a>
<a href="https://hub.docker.com/repository/docker/monolithprojects/systemd-centos8"><img src="https://img.shields.io/docker/cloud/automated/monolithprojects/systemd-centos8?maxAge=2592000"/></a>

CentOS8 docker image with enabled systemd. I am using it with Molecule for Ansible role testing.

## Tags

  - `latest`: Latest version of the image


## How-to

  1. Run command `docker pull monolithprojects/systemd-centos8:latest`  
  2. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro monolithprojects/systemd-centos8:latest`  

## License

MIT
