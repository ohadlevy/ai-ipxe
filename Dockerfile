FROM registry.fedoraproject.org/fedora-minimal:latest

ARG ISO_URL
ENV IMAGE '/data/image.iso'
ENV IPXE_DIR '/data/ipxe'
ENV BASE_URL http://localhost:8888
ENV KERNEL_OPTS 'random.trust_cpu=on rd.luks.options=discard ignition.firstboot ignition.platform.id=metal console=tty1 console=ttyS1,115200n8 coreos.inst.persistent-kargs="console=tty1 console=ttyS1,115200n8"'

RUN microdnf install -y xz gzip genisoimage file cpio && microdnf clean all

COPY iso_to_ipxe /

CMD ./iso_to_ipxe
