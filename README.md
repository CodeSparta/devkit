# CodeSparta Devkit
Developer & Troubleshooting Tools

### Requires:
  1. [Podman](https://podman.io/getting-started/installation.html)
  2. [~/.gitconfig](https://github.com/CodeSparta/devkit/blob/master/docs/gitconfig.md)
  3. ['SSH-to-localhost' Configured](https://github.com/CodeSparta/devkit/blob/master/docs/ssh-to-localhost-config.md)

### Clone Devkit Repo
```
git clone https://github.com/CodeSparta/devkit.git -b master ~/Sparta/devkit && cd ~/Sparta/devkit
```
###  Clone CodeSparta Codebase
  - Declare github username
  - Declare [github auth token](https://github.com/settings/tokens)
  - Declare branch to clone from
  - Declare name of feature branch to branch/checkout

```
./code.yml -e uname=usrbinkat -e token=xxxx -e clone=master -e checkout=master -e branch=feature_uname_purpose
```
###  Cut New CodeSparta Release Tag
```
 ./tag.yml -e tag='master'
```
