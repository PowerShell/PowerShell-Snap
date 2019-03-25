# Docker image file that describes an Ubuntu16.04 image with PowerShell and SnapCraft installed from Microsoft APT Repo
FROM ubuntu:18.04


RUN apt-get update && \
  apt-get dist-upgrade --yes && \
  apt-get install --yes \
  curl sudo jq squashfs-tools && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/core' | jq '.download_url' -r) --output core.snap && \
  mkdir -p /snap/core && unsquashfs -d /snap/core/current core.snap && rm core.snap && \
  curl -L $(curl -H 'X-Ubuntu-Series: 16' 'https://api.snapcraft.io/api/v1/snaps/details/snapcraft?channel=edge' | jq '.download_url' -r) --output snapcraft.snap && \
  mkdir -p /snap/snapcraft && unsquashfs -d /snap/snapcraft/current snapcraft.snap && rm snapcraft.snap && \
  apt remove --yes --purge jq squashfs-tools && \
  apt-get autoclean --yes && \
  apt-get clean --yes

COPY snapcraft-wrapper /snap/bin/snapcraft

ENV PATH=/snap/bin:$PATH

# Install apt-utils (for apt-key used later)
# Install ca-certificates so we can use ssl
# Install curl, used later
# install https for apt
# install git used by snapcraft
RUN apt-get update && \
    apt-get full-upgrade --yes && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        ca-certificates \
        apt-transport-https \
        git && \
# Import the public repository GPG keys for Microsoft
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -  && \
# Register the Microsoft Ubuntu 16.04 repository with apt
    curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list && \
# Update after register new repo
    apt-get update && \
# Install Powershell
    apt-get install --yes \
      powershell && \
# Clean up so the layer is small
    apt remove --yes --purge apt-utils apt-transport-https && \
    apt-get autoclean --yes && \
    apt-get clean --yes && \
    rm /etc/apt/sources.list.d/microsoft.list

COPY powershell-snap.ps1 /powershell-snap.ps1
COPY powershell-snap.sh /powershell-snap.sh
RUN chmod u+x /powershell-snap.sh
