# A small docker image running stunnel

## Base Docker Image
[Debian](https://hub.docker.com/_/debian) Bullseye (x64)

## Software
[stunnel](https://www.stunnel.org/) - A GPL licensed FTP server

## Get the image from Docker Hub
```
docker pull fullaxx/stunnel-server
```

## Networking Options
Define the listening socket with docker port forwarding
```
-p 76.51.51.84:443:443 -e ACCEPT=443
```
Define the backend service connection
```
-e CONNECT=172.17.0.1:80
```

## Certificate Options
There are 2 ways to provide certificate/key files to stunnel \
You can provide a single key+certificate pem file:
```
-v /srv/docker/mydomain/mycerts:/crypto -e CERTKEYFILE=certkey.pem
```
You can provide a certificate file with a seperate key file:
```
-v /srv/docker/mydomain/mycerts:/crypto -e CERTFILE=cert.pem -e KEYFILE=key.pem
```

## Run the image
Run the image listening on 76.51.51.84:443 and connecting to 172.17.0.1:80 using a single PEM file
```
docker run -d \
-p 76.51.51.84:443:443 -e ACCEPT=443 -e CONNECT=172.17.0.1:80 \
-v /srv/docker/mydomain/mycerts:/crypto -e CERTKEYFILE=certkey.pem \
fullaxx/stunnel-server
```
Run the image listening on 76.51.51.84:443 and connecting to 172.17.0.1:80 using seperate PEM files
```
docker run -d \
-p 76.51.51.84:443:443 -e ACCEPT=443 -e CONNECT=172.17.0.1:80 \
-v /srv/docker/mydomain/mycerts:/crypto -e CERTFILE=cert.pem -e KEYFILE=key.pem \
fullaxx/stunnel-server
```

## Build it locally using the github repository
```
docker build -t="fullaxx/stunnel-server" github.com/Fullaxx/stunnel-server
```
