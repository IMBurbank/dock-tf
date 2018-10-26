# Ubuntu-based, Nvidia-GPU-enabled environment for developing changes for TensorFlow, with Jupyter included.
#
# Install the latest version of Bazel and Python development tools.
#
# Configure TensorFlow's shell prompt and login tools.
#
# Launch Jupyter on execution instead of a bash prompt.

FROM dget/docker-tf:1804-gpu-devel

RUN pip install jupyter

RUN mkdir /my-devel && chmod a+rwx /my-devel
RUN mkdir /.local && chmod a+rwx /.local
COPY entry.sh /entry.sh

WORKDIR /my-devel
EXPOSE 8888

ENTRYPOINT ["/entry.sh"]
CMD ["bash", "-c", "jupyter notebook \
        --notebook-dir=/my-devel \
        --ip 0.0.0.0 \
        --no-browser \
        --allow-root"]