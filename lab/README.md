# Local Hypervisor Setup
## Requirements:
1. You have a clean install of [Fedora Workstation/Server](https://getfedora.org/en/workstation/)
2. You have installed [podman](https://podman.io/getting-started/installation.html)
3. There is no critical data on the hypervisor system
    
--------------------------------------------------------------------------------
## Intro:
These playbooks are a rough Sparta developer enablement tools and should be
considered "work-in-progress". This component of devkit enables sparta ocp builds
on modest hardware via the linux hypervisor layers {[libvirt],[kvm],[qemu]}
[libvirt]:https://wiki.libvirt.org/page/Main_Page
[kvm]:https://www.redhat.com/en/topics/virtualization/what-is-KVM
[qemu]:https://www.qemu.org/
--------------------------------------------------------------------------------
# Instructions:
#### 00\. Clone the ocp-mini-stack repo
```sh
sudo dnf install git ansible -y
git clone https://github.com/containercraft/ocp-mini-stack.git ~/.ccio/ocp-mini-stack; cd ~/.ccio/ocp-mini-stack/ansible/
```
#### 02\. Configure Ansible Values
```sh
 vi ~/.ccio/ocp-mini-stack/ansible/vars/user.yml
 vi ~/.ccio/ocp-mini-stack/ansible/hosts.yml
```
--------------------------------------------------------------------------------
# Part 01 -- Build Hypervisor
#### 01\. Run Hypervisor Setup Playbook
```sh
 ./hypervisor-setup -i hosts.yml
```
#### 02\. Run Network Systemd-Networkd Handoff script
```sh
 sudo /bin/bash -c ~/.ccio/ocp-mini-stack/ansible/bin/init-hypervisor-network
```
--------------------------------------------------------------------------------
# Part 03 -- Build Gateway
#### 01\. Stage OpenWRT LXD Gateway Profile and Config Files
```sh
 ./gateway-setup -i hosts.yml
```
#### 02\. Add Image Server & Initialize Gateway
```sh
mkdir /tmp/openwrt
sudo podman run --privileged --rm -it --name openwrt_builder --volume /tmp/openwrt:/root/bin:z containercraft/ccio-openwrt-builder:19.07.2
lxc image import /tmp/openwrt/openwrt-19.07.2-x86-64-lxd.tar.gz --alias openwrt/19.07.2/x86_64
lxc init openwrt/19.07.2/x86_64 gateway -p openwrt
```
#### 03\. Push Config directory to Gateway
```sh
 lxc file push -r /tmp/openwrt/config gateway/etc/
```
#### 04\. Start Gateway and monitor for Address Configuration
```sh
 lxc start gateway
 watch -c lxc list
```
#### 05\. Start Gateway and monitor for Address Configuration
  - Login to the OpenWRT WebUI @ the 'eth0' IP address with `http://${address}:8081`
---------------------------------------------------------------------------------
### Next Steps:
  + [03 Build Bastion]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
--------------------------------------------------------------------------------
<!-- Markdown link & img dfn's -->
[Ansible Automation]:/ansible/README.md
[Manual Method]:/01_Build_Host_ManualMethod.md
[00 Introduction]:/00_Introduction.md
[01 Build Host]:/01_Build_Host.md
[02 Build Gateway]:/02_Build_Gateway.md
[03 Build Bastion]:/03_Build_Bastion.md
[04 Setup_Dns]:/04_Setup_DNS.md
[05 Setup HAProxy]:/05_Setup_HAProxy.md
[06 Setup Dhcp]:/06_Setup_DHCP.md
[07 Setup Nginx]:/07_Setup_Nginx.md
[08 Setup Tftpd]:/08_Setup_Tftpd.md
[09 Deploy Cloud]:/09_Deploy_Cloud.md
[10 Configure Cloud]:/10_Configure_Cloud.md
