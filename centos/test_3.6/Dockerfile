FROM cegekamon/python_base:centos7-3.6

COPY yum_requirements.txt .
USER root
RUN cat yum_requirements.txt | xargs yum install -y
USER apps

COPY requirements.txt .
COPY requirements_dev.txt .
RUN pip install -r requirements.txt -r requirements_dev.txt

