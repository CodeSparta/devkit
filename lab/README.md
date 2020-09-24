# Local Hypervisor Setup
## Requirements:
1. A clean install of [Fedora Workstation/Server](https://getfedora.org/en/workstation/)
2. [Podman](https://podman.io/getting-started/installation.html) installed
3. [~/.gitconfig](https://github.com/CodeSparta/devkit/blob/master/docs/gitconfig.md)
4. There is no critical data on the hypervisor system
5. Run all cmds as root
    
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
git clone git@github.com:CodeSparta/devkit.git -b master /root/devkit && cd /root/devkit
```
--------------------------------------------------------------------------------
## Build Hypervisor on Linux
#### 01\. Execute Into IaC Engine Container Runtime
```sh
 source tools/dev.sh
```
#### 02\. Run Hypervisor Setup Playbook
```sh
 cd lab && ./libvirt.yml
```
#### 03\. Exit IaC Engine
```sh
 exit
```
--------------------------------------------------------------------------------
## [OPTIONAL] Build Virtual Firewall & Gateway
#### 01\. Execute Into IaC Engine Container Runtime
```sh
 source tools/dev.sh
```
#### 02\. Build OpenWRT VFW Container Image
```sh
 mkdir -p /tmp/openwrt && rm -rf /tmp/openwrt/* && sudo podman run --privileged --rm -it --name openwrt_builder --volume /tmp/openwrt:/root/bin:z containercraft/ccio-openwrt-builder:19.07.4
```
#### 03\. Enable host for OpenWRT LXD VFW
```sh
 ./gateway-setup -i hosts.yml
```
#### 04\. Exit IaC Engine
```sh
 exit
```
#### 05\. Build Gateway Container
```sh
 lxc image import /tmp/openwrt/openwrt-19.07.4-x86-64-lxd.tar.gz --alias openwrt/19.07.4/x86_64
 lxc init openwrt/19.07.4/x86_64 gateway -p openwrt
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 06\. Start Gateway and monitor for IPv4 Address
```sh
 lxc start gateway
 watch -c lxc list
```
#### 07\. Set password before logging in on WebUI
```sh
 lxc exec gateway passwd
```
 - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
