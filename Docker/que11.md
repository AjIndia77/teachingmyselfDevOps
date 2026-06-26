# 11.Create an image from the running container and push it into DockerHub as a public image.
For this question you have to make sure You have a login id on DokerHub

Or you can [create](https://hub.docker.com) one
After that on your terminal hit this command
```sh
docker commit condescending_kepler my-apache-mysql
docker tag my-apache-mysql <your_DokerHub_Login_id>/my-apache-mysql:latest
docker login
```
You will get a link and a code which you have to paste on that link after hitting it on the browser
and you will get this output of Login Succeeded

After this you can push your image on the DockerHub
```sh
docker push <your_DokerHub_Login_id>/my-apache-mysql:latest
```
