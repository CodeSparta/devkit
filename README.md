# sparta-devkit
developer kit and contributor materials

## Prepare Sparta Project Dev Workspace
  - Clone Sparta Project
```
git clone git@github.com:CodeSparta/devkit.git ~/Sparta/devkit && cd ~/Sparta/devkit
```
  - Option A) Set usr/token vars 
  - set uname & token in vars/git.yml or vars/usrtoken.yml & enable in ./git.yml
```
./site.yml -e uname=usrbinkat -e token=xxxx
```
or specify branch
```
./site.yml -e branch=mvp1 -e uname=usrbinkat -e token=xxxx
```
## Develop with private repos
  - [Generate a token](https://github.com/settings/tokens)    
    
```
cat <<EOF >> ~/.gitconfig
[user]
        email = usrbinkat@braincraft.io
        name = usrbinkat
[url "https://usrbinkat:0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxfd@github.com"]
        insteadOf = https://github.com
EOF
```
or:
```
git config --global url.UNAME:TOKEN@github.com:.insteadOf https://github.com/
```
Execute Koffer with option:
```
--volume ${HOME}/.gitconfig:/root/.gitconfig:z
```

[Configure devkit to use the token](https://github.com/CodeSparta/devkit/blob/7b60b1947a401bfa4566f4abafb911d5280fcfa5/git.yml#L12)
Execute `./site.yml` to pull in the entire project for local development

## Run koffer container with credentials
```
cat <<EOF > ./bundle.sh 
#!/bin/bash -x
gh_uname="usrbinkat"
gh_token="0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx9fd"
gh_fqdn="github.com"
gh_branch="mvp1"

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
