# CodeSparta Devkit
Developer & Troubleshooting Tools

### Dependencies:
  1. [Podman](https://podman.io/getting-started/installation.html)

## Prepare/Clone Code Development Workspace
  - Clone Sparta Project
```
git clone git@github.com:CodeSparta/devkit.git -b 4.5.8 ~/Sparta/devkit && cd ~/Sparta/devkit
```
## Execute Git Clone:
  - With user/token vars on cli
```
./code.yml -e uname=usrbinkat -e token=xxxx
```
  - Optional: Specify branch to clone devkit from:

```
./code.yml -e uname=usrbinkat -e token=xxxx -e branch=4.5.8 
```
