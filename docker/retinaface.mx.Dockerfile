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
    git \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN echo 'numpy\n\
Cython\n\
cmake\n\
onnxruntime' > /tmp/requirements && \
    pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r /tmp/requirements && \
    rm /tmp/requirements

# RUN pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple insightface
RUN pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple mxnet

WORKDIR /root/insightface
ARG GIT_REPO=https://github.com/deepinsight/insightface.git
RUN git clone ${GIT_REPO} . && \
    cd detection/retinaface && \
    make

ARG DEFAULT_MP_NAME=retinaface-R50
ARG DEFAULT_MP_NAME_DOWNLOAD_URL=http://insightface.cn-sh2.ufileos.com/models/${DEFAULT_MP_NAME}.zip
# RUN echo "DEFAULT_MP_NAME = '${DEFAULT_MP_NAME}'" > /usr/local/lib/python3.9/site-packages/insightface/utils/constant.py
RUN sed -i "s/DEFAULT_MP_NAME\s*=.*/DEFAULT_MP_NAME = '${DEFAULT_MP_NAME}'/" /usr/local/lib/python3.9/site-packages/insightface/utils/constant.py
RUN mkdir -p /root/.insightface/models && \
    curl -L -o /tmp/${DEFAULT_MP_NAME}.zip ${DEFAULT_MP_NAME_DOWNLOAD_URL} && \
    unzip /tmp/${DEFAULT_MP_NAME}.zip -d /root/.insightface/models/${DEFAULT_MP_NAME} && \
    rm /tmp/${DEFAULT_MP_NAME}.zip

