#!/bin/bash -x
clear
sudo rm -rf /tmp/.ssh /tmp/.gitconfig /tmp/.bashrc
cp -rf ~/.ssh ~/.gitconfig ~/.bashrc /tmp/
sudo podman run -it --rm --pull always \
    -h devkit --name devkit --privileged \
    --workdir /root/platform/iac/devkit \
    --volume /tmp/.bashrc:/root/.bashrc:z \
    --volume /tmp/.gitconfig:/root/.gitconfig:z \
    --volume $(pwd):/root/platform/iac/devkit:z \
    --entrypoint bash --volume /tmp/.ssh:/root/.ssh:z \
  docker.io/codesparta/konductor:latest
