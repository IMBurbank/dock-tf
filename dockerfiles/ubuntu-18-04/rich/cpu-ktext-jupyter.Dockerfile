# Ubuntu-based, CPU-only environment for using TensorFlow, with Jupyter,
# ktext and support text analysis/processing packages included. 
#
# Launch Jupyter on execution instead of a bash prompt.

FROM dget/dock-tf:1804

# Maintain pre-0.4.4 due to old ktext dependencies
RUN pip install --no-cache-dir \
        msgpack-numpy==0.4.3.2 \
        && \
    pip install --upgrade --no-cache-dir \
        annoy \
        ipdb \
        jupyter \
        ktext \
        matplotlib \
        nltk \
        pandas \
        seaborn \
        sklearn

RUN mkdir /workdir && \
    chmod a+rwx /workdir && \
    mkdir /.local && \
    chmod a+rwx /.local

WORKDIR /workdir
EXPOSE 8888

ENTRYPOINT ["/entry.sh"]
CMD ["bash", "-c", "jupyter notebook \
        --notebook-dir=/workdir \
        --ip 0.0.0.0 \
        --no-browser \
        --allow-root"]
