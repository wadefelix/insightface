ARG BASEIMAGE=python:3.9-slim-buster
FROM ${BASEIMAGE}

RUN sed -i "s#deb.debian.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list \
 && sed -i "s#security.debian.org#mirrors.tuna.tsinghua.edu.cn#g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive
# Install Dependencies
RUN apt-get -y update && apt-get install -y --fix-missing \
    build-essential \
    cmake \
    curl \
    unzip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN echo 'numpy\n\
Cython\n\
cmake\n\
onnxruntime' > /tmp/requirements && \
    pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r /tmp/requirements && \
    rm /tmp/requirements

RUN pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple insightface

RUN mkdir -p /root/.insightface/models && \
    curl -L -o /tmp/buffalo_l.zip http://insightface.cn-sh2.ufileos.com/models/buffalo_l.zip && \
    unzip /tmp/buffalo_l.zip -d /root/.insightface/models && \
    rm /tmp/buffalo_l.zip

