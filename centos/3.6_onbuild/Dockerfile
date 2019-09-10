FROM cegekamon/python_base:centos-3.6-latest

ARG REQ_FOLDER=.
ENV REQ_FOLDER $REQ_FOLDER

# install centos requirements
ONBUILD ADD $REQ_FOLDER/yum_requirements.txt .
ONBUILD USER root
ONBUILD RUN /opt/apps/scripts/yum_install.sh yum_requirements.txt

ONBUILD USER apps
ONBUILD ADD $REQ_FOLDER/requirements.txt .
ONBUILD RUN /opt/apps/scripts/pip_install.sh requirements.txt

ONBUILD USER root
ONBUILD RUN chown -R apps:apps /opt/apps
ONBUILD RUN chgrp -R 0 /opt/apps/ && chmod -R g+rwX /opt/apps/

ONBUILD USER apps
