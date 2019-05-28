# ubuntu 18.04

## install
`sudo apt-get install openvpn easy-rsa`


## template dir
`make-cadir certificates && cd certificates`
### into `vars` file fill fields:
```
export KEY_COUNTRY=""
export KEY_PROVINCE=""
export KEY_CITY=""
export KEY_ORG=""
export KEY_EMAIL=""
export KEY_OU=""
export KEY_NAME=""
```
#### in `vars` change key-config (default - call script; But we specify the configuration file directly)
`export KEY_CONFIG="$EASY_RSA/openssl-1.0.0.cnf"`


## Generation of the CA
* `source vars`
* `./clean-all && ./build-ca`
* `./build-key-server server` - could be error `../crypto/bio/bss_file.c:74`, no problem?


## Diffie-Hellman parameters generation
`./build-dh`


## Generate a random key to be used as a shared secret
The server and each client will need a copy of this key
`openvpn --genkey --secret keys/ta.key`


## Copy generated files
`sudo cp keys/{server.crt,server.key,ca.crt,dh2048.pem,ta.key} /etc/openvpn`


## OpenVPN configuration
`gzip -d -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz | sudo tee /etc/openvpn/server.conf > /dev/null`

#### Verify that the default values in the configuration file correspond to the ones we generated:
`cat /etc/openvpn/server.conf`

```
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
```

## Setup the firewall and allow ip forwarding

### allow openvpn
`sudo ufw allow openvpn`

### uncoment (by default only the traffic between the client and the server passes over the VPN tunnel, this excludes internet traffic)
* `sudo nano /etc/openvpn/server.conf`
* `push "redirect-gateway def1 bypass-dhcp`

### iptable rule to NAT the VPN client through the internet (Attention `eth0`)
`sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE`
#### make it persistent to reboot
`sudo nano /etc/ufw/before.rules`
Add the rule as the first one in the file:
```
*nat
:POSTROUTING ACCEPT [0:0] 
-A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE
COMMIT
```

## Enable packet forwarding. 
`sudo nano /etc/sysctl.conf`
uncoment: `net.ipv4.ip_forward=1`
### reload
`sudo sysctl -p /etc/sysctl.conf`


## allow packet forwarding through the ufw firewall.
* `sudo nano /etc/default/ufw`
* change DEFAULT_FORWARD_POLICY from DROP to ACCEPT:
`DEFAULT_FORWARD_POLICY="ACCEPT"`
### reload
`sudo ufw reload`


## start and check
* `sudo systemctl start openvpn@server`
* `sudo systemctl is-active openvpn@server`

## For each client we want to use, we must generate a certificate/key pair
* `source vars && ./build-key client`

## generate ovpn
Now we have two options: we can either copy the necessary
files to our client, or we can generate an .ovpn file,
in which the content of those files are embed.
We will concentrate on the second option. 
`mkdir clients && cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf clients/client.ovpn`

## clients/client.ovpn changes:
`remote my-server-1 1194` -> `remote <ip.ip.ip.ip> <port>`

#### uncoment:
```
# Downgrade privileges after initialization (non-Windows only)
user nobody
group nogroup
```

#### First comment references (lines 88-90 and 108)
```
#ca ca.crt
#cert client.crt
#key client.key
#tls-auth ta.key 1
```

#### Next, copy the content of the mentioned files, between the appropriate tags.
```
<ca>
# Here goes the content of the ca.crt file
</ca>

<cert>
# Here goes the content of the <client>.crt file
</cert>

<key>
# Here goes the content of the <client>.key file
</key>
```

#### For the tls-auth key, instead we would do:
```
key-direction 1
<tls-auth>
# The content of the ta.key file
</tls-auth>
```




# * * *
# Create a new client ("Android")
* `cd certificates`
* `source vars && ./build-key android`
* `cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf clients/android.ovpn`
* `nano clients/android.ovpn` - Change fileds, see above
```
<cert>
from android.crt
</cert>

<key>
from android.key
</key>
```
