FROM registry.fedoraproject.org/fedora-minimal:latest

ENV IMAGE '/data/image.iso'
ENV IPXE_DIR '/data/ipxe'
ENV BASE_URL http://localhost:8888
ENV REQUIRE_DATA_DIR true

RUN microdnf install -y xz gzip genisoimage file cpio && microdnf clean all

COPY iso_to_ipxe /

CMD ./iso_to_ipxe
