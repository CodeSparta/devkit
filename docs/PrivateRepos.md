## Develop with private Github repos
  - [Generate a token](https://github.com/settings/tokens)    
```
cat <<EOF >> ~/.gitconfig
[user]
        email = usrbinkat@braincraft.io
        name = usrbinkat
[url "https://usrbinkat:3xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx8@github.com"]
        insteadOf = https://github.com
EOF
```
or:
```
git config --global url.https://usrbinkat:3xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx8@github.com.insteadOf https://github.com
```
Execute Koffer with option:
```
--volume ${HOME}/.gitconfig:/root/.gitconfig:z
```
