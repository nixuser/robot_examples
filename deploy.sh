sudo apt update
sudo apt install -y python3-pip
pip install robotframework

# export PATH=$PATH:~/.local/bin/

sudo apt install podman-docker
docker run -d -p 8080:80 docker.io/kennethreitz/httpbin
