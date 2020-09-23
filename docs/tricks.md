```
sshuttle --dns --ssh-cmd  'ssh -i ~/.ssh/${keyname}' -r ec2-user@${public_ip} 0.0.0.0/0 &
```
