### Make cluster apps routeable on local device
On AWS bastion
```
sudo dnf install python3
```
On your workstation (package available in fedora repos and epel8)
```
sshuttle --dns --ssh-cmd  "ssh -i ~/.ssh/${keyname}" -r ec2-user@${public_ip} --exclude ${public_ip}/32 0.0.0.0/0 &
```
Note: If you're on a system that uses resolved and dnsmasq you will need disable that.  Here's a guide.
https://github.com/CloudCtl/cloudctl/blob/master/doc/systemd-resolved.md

### Add container browser to docker registry service
```
podman run --name registry-browser --rm -it -p 8080:8080 -e DOCKER_REGISTRY_URL=https://10.0.8.42:5000 -e BASIC_AUTH_USER=cloudctl -e BASIC_AUTH_PASSWORD=cloudctl -e NO_SSL_VERIFICATION=true klausmeyer/docker-registry-browser
```
