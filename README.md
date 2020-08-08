# sparta-devkit
developer kit and contributor materials

## Develop with private repos
  - [Generate a token]:(https://github.com/settings/tokens)    
    
```
cat <<EOF >> ~/.gitconfig
[url "usrbinkat:0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxfd@github.com:"]
        insteadOf = https://github.com
EOF
```
or:
```
git config --global url.UNAME:TOKEN@github.com:.insteadOf https://github.com/
```
