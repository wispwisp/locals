# Ubuntu 18.04 VPS


## Log in as root
`ssh root@ip.ip.ip.ip`


## create user
`adduser USER` - interactive answers


## give sudo
`usermod -aG sudo USER`


## set up a firewall
* `ufw app list`
* `ufw allow OpenSSH`
* `ufw enable`
* `ufw status`
### (the firewall is currently blocking all connections except for SSH)
```
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere
OpenSSH (v6)               ALLOW       Anywhere (v6)
```
#### checks
* `netstat -atu`
* `lsof -i`
* `nmap -sT -O -p- localhost`


## Set up login by SSH keys
### (Optional) if not exists
`ssh-keygen`
### Copy Key by hand
#### localhost:
`cat ~/.ssh/id_rsa.pub`
#### vps:
* `su - USER`
* `mkdir .ssh && touch ~/.ssh/authorized_keys`
* `nano ~/.ssh/authorized_keys`
* `chmod -R go= ~/.ssh`

## Disable Password Authentication
* `nano /etc/ssh/sshd_config`
* `PasswordAuthentication no`
* `systemctl restart ssh`


## Log in as new user (also stay logged as root)
`ssh user@ip.ip.ip.ip`
### check u can sudo
`sudo apt update`
