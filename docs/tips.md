### Make cluster apps routeable on local device
```
sshuttle --dns --ssh-cmd  'ssh -i ~/.ssh/${keyname}' -r ec2-user@${public_ip} --exclude ${public_ip}/32 0.0.0.0/0 &
```
### Add container browser to docker registry service
```
podman run --name registry-browser --rm -it -p 8080:8080 -e DOCKER_REGISTRY_URL=https://10.0.8.42:5000 -e BASIC_AUTH_USER=cloudctl -e BASIC_AUTH_PASSWORD=cloudctl -e NO_SSL_VERIFICATION=true klausmeyer/docker-registry-browser
```
