# 1.How do you limit the resources (CPU and memory) that a docker container can use?
 ```sh
docker run -d --cpus="1" -m 100m httpd
