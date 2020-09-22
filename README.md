# CodeSparta Devkit
Developer & Troubleshooting Tools

### Dependencies:
  1. [Podman](https://podman.io/getting-started/installation.html)

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
./code.yml -e uname=usrbinkat -e token=xxxx -e branch=master -e git_checkout=4.5.11
```
