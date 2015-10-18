FROM ubuntu-debootstrap:15.04

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get upgrade -y \
    && apt-get install -y curl julia git python3-jinja2 python3-tornado python3-zmq \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install --disable-pip-version-check ipyparallel>=4.0.2 jupyter>=1.0.0 \
    && julia -e '[Pkg.add(p) for p in ["IJulia", "Interact", "Gadfly", "RDatasets"]]' \
    && apt-get purge -y --auto-remove \
        -o APT::AutoRemove::RecommendsImportant=false \
        -o APT::AutoRemove::SuggestsImportant=false \
        curl \
	&& rm -rf /var/lib/apt/lists/*
COPY rootfs /

VOLUME /notebooks
EXPOSE 8888
WORKDIR /root
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--notebook-dir=/notebooks", "--port=8888"]
