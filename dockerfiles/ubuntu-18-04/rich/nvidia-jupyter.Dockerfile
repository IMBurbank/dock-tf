# Ubuntu-based, Nvidia-GPU-enabled environment for using TensorFlow, with Jupyter included.
#
# Configure TensorFlow's shell prompt and login tools.
#
# Launch Jupyter on execution instead of a bash prompt.

FROM dget/dock-tf:1804-gpu

RUN pip install --no-cache-dir jupyter

RUN mkdir /workdir && \
    chmod a+rwx /workdir && \
    mkdir /.local && \
    chmod a+rwx /.local
    
COPY entry.sh /entry.sh

WORKDIR /workdir
EXPOSE 8888

ENTRYPOINT ["/entry.sh"]
CMD ["bash", "-c", "jupyter notebook \
        --notebook-dir=/workdir \
        --ip 0.0.0.0 \
        --no-browser \
        --allow-root"]