FROM centos:centos6
MAINTAINER Bas Meijer <bas.meijer@me.com>

RUN mkdir -p /tmp/ansible/roles/base_miniconda
RUN yum install -y epel-release && \
    yum install -y ansible && \
    yum clean all
COPY ./files/hosts /etc/ansible/hosts
ADD . /tmp/ansible/roles/base_miniconda
COPY ./molecule/default/provision.yml ./molecule/default/vars.yml /tmp/ansible/
RUN cd /tmp/ansible && ansible-playbook provision.yml
ENV PATH /opt/conda/envs/env/bin:$PATH
