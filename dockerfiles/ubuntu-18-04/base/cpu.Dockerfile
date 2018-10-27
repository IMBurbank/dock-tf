# Ubuntu-based, CPU-only environment for using TensorFlow
#
# Python is required for TensorFlow and other libraries.
# --build-arg USE_PYTHON_3_NOT_2=True
#    Install python 3 over Python 2
#
# Install the TensorFlow Python package.
# --build-arg TF_PACKAGE=tensorflow (tensorflow|tensorflow-gpu|tf-nightly|tf-nightly-gpu)
#    The specific TensorFlow Python package to install
#
# Configure TensorFlow's shell prompt and login tools.

FROM ubuntu:18.04

ARG USE_PYTHON_3_NOT_2=True
ARG _PY_SUFFIX=${USE_PYTHON_3_NOT_2:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
        ${PYTHON} \
        ${PYTHON}-pip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ${PIP} install --upgrade \
        pip \
        setuptools

COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

RUN RUN ${PIP} install --upgrade \
    tensorflow