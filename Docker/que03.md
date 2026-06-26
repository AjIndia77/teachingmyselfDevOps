# 3.Can you explain the different volume mount types available in Docker?
--> 2 types of volume mount :- 
1. Bind mount 
 ```sh
 mkdir bind
 cd bind
``` 
 then we create a file

 ```sh
 
vi index.html # write in the file <It works!>
cd
```
create the container and mount bind volume
```sh
docker container run -d -p 80:80 -v /root/bind/:/usr/local/apache2/htdocs --name bind-cont httpd 
```
2. local mount 
from local mount we can mount volume in one command
```sh
docker container run -d -p 80:80 -v local:/usr/local/apache2/htdocs --name local-cont httpd
```
to verify
```sh
cd /var/lib/docker/volumes/local/_data
ls
index.html
cat index.html
```
This output you will see:
It works!

