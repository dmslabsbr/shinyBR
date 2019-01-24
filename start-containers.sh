#!/bin/bash

# cria os diretórios no servidor host
mkdir -p /srv/shiny-server/log
mkdir -p /srv/shiny-server/cfg
mkdir -p /srv/shiny-server/apps

#copia arquivos de configuração, caso não exista
cp -u shiny-server.conf.txt /srv/shiny-server/cfg/shiny-server.conf

#copia aplicação
cp -u index.html /srv/shiny-server/apps


# inicia Shiny-server
docker run -d --name shiny --restart always \
    -p 3839:3838 \
    --dns=8.8.8.8 \
    -e PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' \
    -e R_VERSION='3.5.1' \
    -e LC_ALL='pt_BR.UTF-8' \
    -e LANG='pt_BR.UTF-8' \
    -e TERM='xterm' \
    -e TZ='America Sao_Paulo' \
    -v /srv/shiny-server/apps/:/srv/shiny-server/ \
    -v /srv/shiny-server/log/:/var/log/shiny-server/ \
    -v /srv/shiny-server/cfg:/etc/shiny-server \
    dmslabsbr/shinybr /usr/bin/shiny-server.sh

    
# Start portainer_app
docker run -d --name portainer_app --restart always \
    -p 9001:9000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /opt/portainer/data:/data \
    portainer/portainer
    

# Start filebrowser_app
docker run -d --name filebrowser_app --restart always \
      -p 9002:80 \
      -v /srv/filebrowser/config.json:/config.json \
      -v /srv/filebrowser/etc:/etc \
      -v /srv/shiny-server/apps:/srv/app \
      -v /srv/shiny-server/log:/srv/log \
    filebrowser/filebrowser
    
    
# Start samba_app - Please change the password
docker run -d --name samba_app --restart always \
      -p 139:139 \
      -p 445:445 \
      -v /srv/shiny-server/apps:/srv/apps \
      -v /srv/shiny-server/log:/srv/log \
    dperson/samba -u "ggi;Rserverggi" \
    -s "shiny;/srv;yes;no;yes;all;ggi;ggi;'Pasta R Shiny Server'"
    
