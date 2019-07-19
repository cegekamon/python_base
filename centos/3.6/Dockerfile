FROM centos:centos7.6.1810

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
ENV VIRTUAL_ENV /opt/app_venv

# create apps user
USER root
RUN useradd -u $USER_ID apps
RUN usermod -aG wheel apps

# create folders for the app
RUN mkdir /opt/app_root && chown apps:apps -R /opt/app_root
RUN mkdir /opt/app_venv && chown apps:apps -R /opt/app_venv

# install centos requirements
ONBUILD ADD requirements/centos centos
ONBUILD USER root
ONBUILD RUN bash -c '[ -s centos ] && cat centos | xargs yum install -y || echo "File empty"'
ONBUILD USER apps

# operate as apps
USER apps

# setup workspace
RUN python3.6 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
WORKDIR /opt/app_root

# pip install app requirements
RUN pip install --upgrade pip
ONBUILD ADD requirements/pip requirements.txt
ONBUILD RUN pip install -r requirements.txt