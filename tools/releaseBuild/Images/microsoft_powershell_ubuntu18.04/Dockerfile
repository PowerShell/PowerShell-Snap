# Docker image file that describes an Ubuntu16.04 image with PowerShell and SnapCraft installed from Microsoft APT Repo
FROM mcr.microsoft.com/powershell:ubuntu-22.04@sha256:73c08403182e3cd1a62176b6723645b2d2037cda8deefc0e2c2c01cb814abe43

ARG SNAPCRAFT_CHANNEL=stable

ENV SNAPCRAFT_URL=https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=${SNAPCRAFT_CHANNEL}
# Install curl, used later
# install git used by snapcraft
RUN echo SNAPCRAFT_URL: ${SNAPCRAFT_URL} && \
  apt-get update && \
  apt-get dist-upgrade --yes && \
  apt-get install --yes \
    curl \
    sudo \
    jq \
    squashfs-tools \
    git && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/core20' | jq '.download_url' -r) --output core20.snap && \
  mkdir -p /snap/core20 && unsquashfs -d /snap/core20/current core20.snap && rm core20.snap && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' ${SNAPCRAFT_URL} | jq '.download_url' -r) --output snapcraft.snap && \
  mkdir -p /snap/snapcraft && unsquashfs -d /snap/snapcraft/current snapcraft.snap && rm snapcraft.snap && \
  apt remove --yes --purge jq squashfs-tools && \
  apt-get autoclean --yes && \
  apt-get clean --yes

COPY snapcraft-wrapper /snap/bin/snapcraft

ENV PATH=/snap/bin:$PATH

COPY powershell-snap.ps1 /powershell-snap.ps1
COPY powershell-snap.sh /powershell-snap.sh
RUN chmod u+x /powershell-snap.sh
