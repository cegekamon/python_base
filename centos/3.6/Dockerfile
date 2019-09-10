FROM centos:centos7.6.1810 AS build_

# set up environment variables
ENV PYTHON_VERSION=3.6 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off \
    VIRTUAL_ENV=/opt/app_venv

# install python 3.6
RUN yum update -y \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y python36u python36u-libs python36u-devel python36u-pip \
    && yum -y clean all --enablerepo='*' \
    && rm -rf /var/cache/yum

ENV USER_ID 1000
ENV VIRTUAL_ENV /opt/apps/app_venv
ENV APP_ROOT /opt/apps/app_root
ENV SCRIPTS_ROOT /opt/apps/scripts

# create apps user
USER root
RUN mkdir /opt/apps
RUN useradd -u $USER_ID apps --home /opt/apps
RUN chown apps:apps /opt/apps

COPY scripts $SCRIPTS_ROOT
RUN chmod +x $SCRIPTS_ROOT/*.sh && chown apps:apps -R $SCRIPTS_ROOT

# create folders for the app
RUN mkdir $APP_ROOT && chown apps:apps -R $APP_ROOT
RUN mkdir $VIRTUAL_ENV && chown apps:apps -R $VIRTUAL_ENV

# operate as apps
USER apps

# setup workspace
RUN python3.6 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
WORKDIR $APP_ROOT

# pip install app requirements
RUN pip install --upgrade pip

# allow all users to access the files in /opt/apps
# necessary for OpenShift, as it runs with a random UID
USER root
RUN chown -R apps:apps /opt/apps
RUN chgrp -R 0 /opt/apps/ && chmod -R g+rwX /opt/apps/

USER apps