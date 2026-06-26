# 6.How will you configure the docker client separately from the docker host/server?
```sh
sudo nano /lib/systemd/system/docker.service
```
then we replace a line with another
```sh
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock #REPLACE WITH THIS LINE 
```
```sh
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --containerd=/run/containerd/containerd.sock
```
then reload and restart docker
```sh
sudo systemctl daemon-reload
sudo systemctl restart docker
```
then verify if the docker running with 2375
```sh
ss -tulnp | grep dockerd
```
and get this outut
```sh
tcp   LISTEN 0      4096                   *:2375            *:*    users:(("dockerd",pid=12687,fd=4))
```
and then
```sh
docker info
