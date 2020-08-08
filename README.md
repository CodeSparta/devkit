# sparta-devkit
developer kit and contributor materials

## Develop with private repos
  - [Generate a token](https://github.com/settings/tokens)    
    
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
Execute Koffer with option:
```
--volume ${HOME}/.gitconfig:/root/.gitconfig:z
```

[Configure devkit to use the token](https://github.com/CodeSparta/devkit/blob/7b60b1947a401bfa4566f4abafb911d5280fcfa5/git.yml#L12)
Execute `./site.yml` to pull in the entire project for local development
