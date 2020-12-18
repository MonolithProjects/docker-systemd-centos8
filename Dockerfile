FROM centos:8
LABEL maintainer="Michal Muransky"
WORKDIR /lib/systemd/system/sysinit.target.wants/
ENV \
    container=docker \
	MY_USER=ansible \
	MY_GROUP=ansible \
	MY_UID=1000 \
	MY_GID=1000

RUN for i in * ; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i" ; done ; \
    rm -f /lib/systemd/system/multi-user.target.wants/* ; \
    rm -f /etc/systemd/system/*.wants/* ; \
    rm -f /lib/systemd/system/local-fs.target.wants/* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -f /lib/systemd/system/basic.target.wants/* ; \
    rm -f /lib/systemd/system/anaconda.target.wants/*

RUN yum makecache --timer \
    && yum -y install \
        initscripts \
        sudo \
        which \
        python3 \
        python3-pip \
    && yum clean all

RUN set -eux \
    && groupadd -g ${MY_GID} ${MY_GROUP} \
    && useradd -d /home/ansible -s /bin/bash -G ${MY_GROUP} -g ${MY_GID} -u ${MY_UID} ${MY_USER} \
    && echo "${MY_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers \
    \
    && mkdir /home/ansible/.gnupg \
    && chown ansible:ansible /home/ansible/.gnupg \
    && chmod 0700 /home/ansible/.gnupg \
    \
    && mkdir /home/ansible/.ssh \
    && chown ansible:ansible /home/ansible/.ssh \
    && chmod 0700 /home/ansible/.ssh 

RUN mkdir -p /etc/ansible
# hadolint ignore=SC2039
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
