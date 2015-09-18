FROM ubuntu-debootstrap:15.10

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:staticfloat/juliareleases \
    && apt-get update \
    && apt-get install -y curl julia git python3 python3-jinja2 python3-tornado python3-zmq \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install ipyparallel==4.0.2 jupyter==1.0.0 \
    && julia --eval 'Pkg.add("IJulia")' \
    && jupyter notebook --generate-config \
    && apt-get purge -y --auto-remove \
		-o APT::AutoRemove::RecommendsImportant=false \
		-o APT::AutoRemove::SuggestsImportant=false \
		curl git \
	&& rm -rf /var/lib/apt/lists/*

VOLUME /notebooks
EXPOSE 8888
CMD jupyter notebook --ip=* --notebook-dir=/notebooks --port 8888
