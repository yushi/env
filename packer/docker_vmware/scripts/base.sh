sleep 30
apt-get update
curl https://get.docker.io/gpg | apt-key add -
echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y --force-yes lxc-docker
