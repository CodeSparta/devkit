# Local Hypervisor Setup
## Requirements:
1. A clean install of [Fedora Workstation/Server](https://getfedora.org/en/workstation/)
2. [Podman](https://podman.io/getting-started/installation.html) installed
3. [~/.gitconfig](https://github.com/CodeSparta/devkit/blob/master/docs/gitconfig.md) configured with token auth
4. There is no critical data on the hypervisor system
5. Run all cmds as root
6. Configure root to be able to ssh to itself [SSH to localhost](https://github.com/CodeSparta/devkit/blob/master/docs/ssh-to-localhost-config.md)
    
## Intro:    
These playbooks represent rough Sparta developer enablement tools and should be
considered "work-in-progress". This component of devkit enables sparta ocp builds
on modest hardware via the linux hypervisor layers {{ [libvirt],[kvm],[qemu] }}

[libvirt]:https://wiki.libvirt.org/page/Main_Page
[kvm]:https://www.redhat.com/en/topics/virtualization/what-is-KVM
[qemu]:https://www.qemu.org/

## Instructions:
#### 00\. Clone the Devkit Repository
```sh
 git clone https://github.com/CodeSparta/devkit.git -b master /root/devkit && cd /root/devkit
```
--------------------------------------------------------------------------------
## Build Hypervisor on Linux
#### 01\. Start TMUX session for safety
```sh
 tmux
```
#### 02\. Execute Into IaC Engine Container Runtime
```sh
 source tools/dev.sh
```
#### 03\. Run Hypervisor Setup Playbook
```sh
 cd ./lab && ./network-setup.yml -vv
```
#### 04\. SSH back & Run Hypervisor Setup Playbook
```sh
 ./hypervisor-setup.yml -vv
```
#### 05\. Exit IaC Engine
```sh
 exit
```
--------------------------------------------------------------------------------
## [OPTIONAL] Build Virtual Firewall & Gateway
#### 01\. Build OpenWRT VFW Container Image
```sh
 mkdir -p /tmp/openwrt && rm -rf /tmp/openwrt/* && sudo podman run --privileged --rm -it --name openwrt_builder --volume /tmp/openwrt:/root/bin:z containercraft/ccio-openwrt-builder:19.07.4
```
#### 02\. Execute Into IaC Engine Container Runtime
```sh
 source tools/dev.sh
```
#### 03\. Enable host for OpenWRT LXD VFW
```sh
 cd ./lab && ./gateway-setup.yml -vv
```
#### 04\. Exit IaC Engine
```sh
 exit
```
#### 05\. Reload environment
```sh
 bash
```
#### 06\. Build Gateway Container
```sh
 lxc image import /tmp/openwrt/openwrt-19.07.4-x86-64-lxd.tar.gz --alias openwrt/19.07.4/x86_64
 lxc init openwrt/19.07.4/x86_64 gateway -p openwrt
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 07\. Start Gateway and monitor for IPv4 Address
```sh
 lxc start gateway
 watch -c lxc list
```
#### 08\. Set password before logging in on WebUI
```sh
 lxc exec gateway passwd
```
 - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
