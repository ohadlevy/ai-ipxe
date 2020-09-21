# Assisted Installer IPXE

A container that extracts from AI (Assisted Installer) Generated ISO and populate a IPXE bootable script and medium files.

## How to use

Make sure you that you have downloaded your ISO or have a *valid* URL for it.


an example usage if you have downloaded the image already:

this assumes that your image is located under /var/tmp/ai and its called image.iso

```
podman run -v /var/tmp/ai:/data:Z -it --rm quay.io/ohadlevy/ai-ipxe 
```


or let the container download the iso for you.

```
# ISO_URL is where the Assisted Installer ISO for your cluster is located
# BASE_URL is where your iPXE files will be hosted

podman run -e BASE_URL=$(hostname):8080 -e ISO_URL=http.... -v /var/tmp/ai:/data:Z --net=host -it --rm quay.io/ohadlevy/ai-ipxe 
```

under /var/tmp/ai you would find an ipxe directory with all needed files

You would need to host these generated files over http for ipxe to access, please make sure that you know under which URL they would be accessible

if you don't have a web server, you could use 
```
podman run  -v /var/tmp/ai/ipxe:/app:ro -p 8080:8080 -d --rm bitnami/nginx:latest
```
you would either need to adjust the base url in /var/tmp/ai/ipxe/ipxe or to use the BASE_URL container environment variable to override.

lastly, you would need to boot ipxe, a simple way to test on a vm, while ipxe is booting, press ctrl-b and type:
```
dhcp
chain <your base url>/ipxe
```
