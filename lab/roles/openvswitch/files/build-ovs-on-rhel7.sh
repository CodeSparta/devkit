#!/bin/bash
set -xe

if ! id -u ovs > /dev/null 2>&1; then
  useradd ovs
fi

su -c -u ovs 'mkdir -p /home/ovs/rpmbuild/SOURCES'
su -c -u ovs 'wget http://openvswitch.org/releases/openvswitch-2.12.0.tar.gz -P /home/ovs/'
su -c -u ovs 'cp /home/ovs/openvswitch-2.12.0.tar.gz /home/ovs/rpmbuild/SOURCES/'
su -c -u ovs 'cd /home/ovs/rpmbuild/SOURCES/ && tar xfz openvswitch-2.12.0.tar.gz'
su -c -u ovs 'cd /home/ovs/rpmbuild/SOURCES/ && rpmbuild -bb --nocheck openvswitch-2.12.0/rhel/openvswitch-fedora.spec'
