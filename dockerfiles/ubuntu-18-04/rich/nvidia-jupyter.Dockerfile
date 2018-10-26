# Ubuntu-based, Nvidia-GPU-enabled environment for using TensorFlow, with Jupyter included.
#
# Configure TensorFlow's shell prompt and login tools.
#
# Launch Jupyter on execution instead of a bash prompt.

FROM dget/dock-tf:1804-gpu

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