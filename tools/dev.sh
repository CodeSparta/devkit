#!/bin/bash -x
clear
cp -rf ~/.ssh ~/.gitconfig ~/.bashrc /tmp/
sudo podman run -it --rm --pull always \
    -h konductor --name konductor \
    --entrypoint bash --privileged \
    --volume /tmp/.ssh:/root/.ssh:z \
    --volume /tmp/.bashrc:/root/.bashrc:z \
    --volume /tmp/.gitconfig:/root/.gitconfig:z \
    --volume $(pwd):/root/platform/iac/devkit:z \
    --workdir /root/platform/iac/devkit \
  docker.io/codesparta/konductor:latest
