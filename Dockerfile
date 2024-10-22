FROM mambaorg/micromamba:2.0-cuda11.7.1-ubuntu20.04

USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -s $(which micromamba) /usr/bin/conda
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    apt update \
    && apt install -y \
        build-essential \
        wget \
        libxml2-dev

USER mambauser
WORKDIR /opt/diffuscene

ADD environment.yaml environment.yaml
RUN --mount=type=cache,target=/root/.cache/pip \
    conda env create -y -f environment.yaml
ENV ENV_NAME=diffuscene

ADD . .

RUN python setup.py build_ext --inplace
RUN pip install -e .

RUN cd ChamferDistancePytorch/chamfer3D && python setup.py install