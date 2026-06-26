# 5.When you restart the docker service, all your container goes down, so how you will overcome this problem?
```sh
docker run --restart always -d httpd
docker container inspect <container-id>
