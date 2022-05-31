# As this is a derived service from the image classification model
# so we can resuse the original image classification image.

# Options: cpu, gpu, cpu-test, gpu-test
ARG tag=cpu

# Base image, e.g. tensorflow/tensorflow:1.12.0-py3
FROM deephdc/deep-oc-image-classification-tf:${tag}

# Add container's metadata to appear along the models metadata
ENV CONTAINER_MAINTAINER "Lara Lloret Iglesias <lloret@ifca.unican.es>"
ENV CONTAINER_VERSION "0.1"
ENV CONTAINER_DESCRIPTION "DEEP as a Service Container: Phytoplankton Classification"

# Download network weights
ENV SWIFT_CONTAINER https://api.cloud.ifca.es:8080/swift/v1/phytoplankton-tf/
ENV MODEL_TAR phytoplankton.tar.xz

RUN rm -rf image-classification-tf/models/*

RUN curl --insecure -o ./image-classification-tf/models/${MODEL_TAR} \
    ${SWIFT_CONTAINER}${MODEL_TAR}

RUN cd image-classification-tf/models && \
    tar -xf ${MODEL_TAR} &&\
    rm ${MODEL_TAR}
