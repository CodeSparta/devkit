## Zero HITL Example
  1. Create `~/.docker/config.json` with quay pull secret
  2. Write declarative Koffer Config
```
cat <<EOF > sparta.yml
koffer:
  silent: true
  plugins:
    collector-infra:
      service: github.com
      organization: codesparta
      branch: master
      version: 4.5.11
EOF
```
  3. Execute Koffer
```
cat <<EOF > run.sh && chmod +x run.sh && ./run.sh
#!/bin/bash -x
mkdir -p ~/bundle
sudo podman run -it --rm --pull always \
    --privileged --device /dev/fuse \
    --volume \$(pwd)/bundle:/root/deploy/bundle:z \
    --volume \${HOME}/.docker/config.json:/root/.docker/config.json:z \
    --volume \$(pwd)/sparta.yml:/root/.koffer/config.yml:z \
  docker.io/codesparta/koffer bundle --silent
EOF
```
