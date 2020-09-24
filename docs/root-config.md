## Configure root so that it can ssh to itself
step 1: Configure passwordless ssh
```
ssh-keygen
```
step 2:

```
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys

```
then

```
chown root -R /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/authorized_keys

```

### restart the ssh daemon

```
systemctl restart sshd

```
