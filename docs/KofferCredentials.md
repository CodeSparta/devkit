## Run koffer container with credentials
```
cat <<EOF > ./bundle.sh 
#!/bin/bash -x
gh_uname="usrbinkat"
gh_token="0xxxxxxxxxx9fd"
gh_fqdn="github.com"
gh_branch="4.5.8"

sudo podman run -it --rm \
    --privileged --device /dev/fuse \
    --volume /tmp/bundle:/root/deploy/bundle:z \
    --volume ${HOME}/.gitconfig:/root/.gitconfig:z \
  docker.io/codesparta/koffer bundle \
    --branch ${gh_branch}\
    --service "${gh_uname}:${gh_token}@${gh_fqdn}" \
    --repo collector-infra

sudo tar xv -f /tmp/bundle/koffer-bundle.openshift-*.tar -C /root

EOF
chmod +x ./bundle.sh
```
Then execute
```
./bundle.sh
```
Then become root
```
sudo -i
```
and continue as usual
```
ls
```
