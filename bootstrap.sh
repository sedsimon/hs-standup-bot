#!/bin/bash

# repos
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# init
apt-get update 2> /dev/null

# redis
apt-get install -y redis-server 2> /dev/null

# Mongo
apt-get install mongodb-org -y 2> /dev/null

# ntp
apt-get install ntp -y 2> /dev/null
service ntp restart

# install dependencies and services
apt-get install monit -y 2> /dev/null
apt-get install unzip -y 2> /dev/null
apt-get install -y vim curl 2> /dev/null

# Python things
apt-get install -y python-pip 2> /dev/null

# install ngrok
wget -qO /tmp/ngrok.zip https://dl.ngrok.com/linux_386/ngrok.zip
unzip /tmp/ngrok.zip
mv ngrok /usr/local/bin/ngrok

# configure monit
cat <<EOF > /etc/monit/conf.d/ngrok
set httpd port 5150 and
    use address localhost
    allow localhost

set daemon 30
#with start delay 5

check process ngrok matching "/usr/local/bin/ngrok"
    start program = "/bin/bash -c '2>&1 1>>/var/log/ngrok.log /usr/local/bin/ngrok -log=stdout 5000'"
    stop program = "/usr/bin/killall ngrok"
EOF

# restart monit service
service monit restart
sleep 2
monit monitor all

# start Mongo
# service mongod restart
# service redis-server restart


# set vim tabs
cat <<EOF > /home/vagrant/.vimrc
set tabstop=4
EOF
chown vagrant.vagrant /home/vagrant/.vimrc

# Print ngrok on login
cat <<EOF >> /home/vagrant/.profile
echo -e '\e[1m'
grep "Tunnel established" /var/log/ngrok.log | tail -1 | sed 's/.*Tunnel/Tunnel/g'
echo
tput sgr0
echo "Run 'cd project && python app.py' to start your application."
echo
EOF

# Install project dependencies
pip install -U -r /home/vagrant/project/requirements.txt


