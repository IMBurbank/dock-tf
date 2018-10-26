# Ubuntu-based, CPU-only environment for using TensorFlow, with Jupyter,
# ktext and support text analysis/processing packages included. 
#
# Launch Jupyter on execution instead of a bash prompt.

FROM dget/dock-tf:1804

# Maintain pre-0.4.4 due to old ktext dependencies
RUN pip install \
        msgpack-numpy==0.4.3.2

RUN pip install --upgrade \
        annoy \
        ipdb \
        jupyter \
        ktext \
        matplotlib \
        nltk \
        pandas \
        seaborn \
        sklearn

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
