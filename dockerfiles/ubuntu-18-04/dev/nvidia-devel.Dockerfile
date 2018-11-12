# Ubuntu-based, Nvidia-GPU-enabled environment for developing changes for TensorFlow.
#
# Start from Nvidia's Ubuntu base image with CUDA and CuDNN, with TF development
# packages.
#
# Install the latest version of Bazel and Python development tools.
#
# Configure TensorFlow's shell prompt and login tools.

FROM dget/dock-tf:1804-gpu


RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        libcurl3-dev \
        rsync \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        libnccl-dev=2.2.13-1+cuda9.0 \
        wget \
        && \
    find /usr/local/cuda-9.0/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    apt-get update && apt-get install -y \
        libnvinfer-dev=4.1.2-1+cuda9.0 \
        && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

# Link NCCL libray and header where the build script expects them.
RUN mkdir /usr/local/cuda-9.0/lib &&  \
    ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/lib/libnccl.so.2 && \
    ln -s /usr/include/nccl.h /usr/local/cuda/include/nccl.h

RUN apt-get update && \
    apt-get install -y \
        openjdk-8-jdk \
        python3-dev \
        swig \
        && \
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
        | tee /etc/apt/sources.list.d/bazel.list && \
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        bazel \
        && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

ENTRYPOINT ["/entry.sh"]
CMD bash -l
