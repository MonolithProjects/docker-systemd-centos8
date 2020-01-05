FROM centos:8
LABEL maintainer="Michal Muransky"
WORKDIR /lib/systemd/system/sysinit.target.wants/
ENV container=docker

RUN for i in * ; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i" ; done ; \
    rm -f /lib/systemd/system/multi-user.target.wants/* ; \
    rm -f /etc/systemd/system/*.wants/* ; \
    rm -f /lib/systemd/system/local-fs.target.wants/* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -f /lib/systemd/system/basic.target.wants/* ; \
    rm -f /lib/systemd/system/anaconda.target.wants/*

RUN yum makecache --timer \
 && yum -y install initscripts \
 && yum -y install \
      sudo \
      which \
      python3 \
      python3-pip \
 && yum clean all

RUN mkdir -p /etc/ansible
# hadolint ignore=SC2039
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
