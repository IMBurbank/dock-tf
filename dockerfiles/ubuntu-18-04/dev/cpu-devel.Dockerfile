# Ubuntu-based, CPU-only environment for developing changes for TensorFlow.
#
# Install the latest version of Bazel and Python development tools.
#
# Configure TensorFlow's shell prompt and login tools.

FROM dget/dock-tf:1804


RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng-dev \
        libzmq3-dev \
        openjdk-8-jre-headless \
        pkg-config \
        python-dev \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        libcurl3-dev \
        rsync \
        zip \
        zlib1g-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        openjdk-8-jdk \
        python3-dev \
        swig \
        && \
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
        | tee /etc/apt/sources.list.d/bazel.list && \
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        Bazel \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
