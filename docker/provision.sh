cat > /etc/profile.d/docker.sh <<EOS
alias docker='docker -H=tcp://127.0.0.1:4243'
EOS

cat > /etc/init/docker.conf <<EOS
description     "Docker daemon"

start on filesystem or runlevel [2345]
stop on runlevel [!2345]

respawn

script
    /usr/bin/docker -d -r --dns=10.0.3.1 -H=tcp://0.0.0.0:4243
end script
EOS

service docker restart
