# Local Hypervisor Setup
## Requirements:
1. A clean install of [Fedora Workstation/Server](https://getfedora.org/en/workstation/)
2. [Podman](https://podman.io/getting-started/installation.html) installed
3. There is no critical data on the hypervisor system
    
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
git clone git@github.com:CodeSparta/devkit.git -b 4.5.8 ~/Sparta/devkit && cd ~/Sparta/devkit
```
--------------------------------------------------------------------------------
## Part 01 -- Build Hypervisor Layer
#### 01\. Execute Into IaC Engine Container Runtime
```sh
 source tools/dev.sh
```
#### 01\. Run Hypervisor Setup Playbook
```sh
 ./libvirt.yml
```
--------------------------------------------------------------------------------
## Part 02 OPTIONAL -- Build Virtual Firewall & Gateway
#### 01\. Add Image Server & Initialize Gateway
```sh
 mkdir -p /tmp/openwrt
 sudo podman run --privileged --rm -it --name openwrt_builder --volume /tmp/openwrt:/root/bin:z containercraft/ccio-openwrt-builder:19.07.4
 lxc image import /tmp/openwrt/openwrt-19.07.4-x86-64-lxd.tar.gz --alias openwrt/19.07.4/x86_64
```
#### 02\. Stage OpenWRT LXD Gateway Profile and Config Files
```sh
 ./gateway-setup -i hosts.yml
```
#### 03\. Push Config directory to Gateway
```sh
 lxc init openwrt/19.07.4/x86_64 gateway -p openwrt
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 04\. Start Gateway and monitor for Address Configuration
```sh
 lxc start gateway
 watch -c lxc list
```
#### 05\. Start Gateway and monitor for Address Configuration
 - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
