# Docker image file that describes an Ubuntu16.04 image with PowerShell installed from Microsoft APT Repo
FROM microsoft/powershell:ubuntu16.04

# change channel=beta on line 11 to stable when .38 becomes stable.
RUN apt-get update && \
  apt-get dist-upgrade --yes && \
  apt-get install --yes \
  curl sudo jq squashfs-tools git patchelf && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/core' | jq '.download_url' -r) --output core.snap && \
  mkdir -p /snap/core && unsquashfs -d /snap/core/current core.snap && rm core.snap && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=beta' | jq '.download_url' -r) --output snapcraft.snap && \
  mkdir -p /snap/snapcraft && unsquashfs -d /snap/snapcraft/current snapcraft.snap && rm snapcraft.snap && \
  mkdir -p /snap/bin && ln -s /snap/snapcraft/current/bin/snapcraft-classic /snap/bin/snapcraft && \
  apt remove --yes --purge curl jq && \
  apt-get autoclean --yes && \
  apt-get clean --yes

ENV SNAP=/snap/snapcraft/current
ENV SNAP_NAME=snapcraft
ENV SNAP_VERSION=beta
ENV PATH=/snap/bin:$PATH

COPY powershell-snap.ps1 /powershell-snap.ps1
COPY powershell-snap.sh /powershell-snap.sh
RUN chmod u+x /powershell-snap.sh
# Required by click.
ENV LC_ALL C.UTF-8

