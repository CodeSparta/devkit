# CodeSparta Devkit
Developer & Troubleshooting Tools

## Prepare/Clone Code Development Workspace
  - Clone Sparta Project
```
git clone git@github.com:CodeSparta/devkit.git -b 4.5.8 ~/Sparta/devkit && cd ~/Sparta/devkit
```
  - Option A) Set uname & token in [vars/git.yml](./vars/git.yml#L12)
  - Option B) Declare user/token vars on cli
```
./code.yml -e uname=usrbinkat -e token=xxxx
```
  - Option C) Specify branch
```
./code.yml -e uname=usrbinkat -e token=xxxx -e branch=4.5.8 
```
