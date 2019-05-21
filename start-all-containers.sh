#!/bin/bash
echo -e "Loading variables \e[95m.....\e[0m"

ARQ1="variables.sh"
ARQ2=mp."$ARQ1"

if [ -f "$ARQ2" ]; then
    # run other
    . "$ARQ2"
else
    # run default
    . "$ARQ1"
fi
echo -e "MSG FILE: \e[91m"$ARQ_MSG"\e[0m"

echo -e "Starting containers \e[95m.....\e[0m"
# cria os diretórios no servidor host
echo -e ".... \e[92mCreating folders \e[0m"
mkdir -p "$R_SERVER_FOLDER"/log
mkdir -p "$R_SERVER_FOLDER"/cfg
mkdir -p "$R_SERVER_FOLDER"/apps
mkdir -p "$R_SERVER_FOLDER"/app1
mkdir -p "$R_SERVER_FOLDER"/app2
mkdir -p "$R_SERVER_FOLDER"/app3
mkdir -p "$R_SERVER_FOLDER"/appTst

echo -e ".... \e[92mCopying configurations files.\e[0m"
#copia arquivos de configuração, caso não exista
cp -u shiny-server.conf.txt "$R_SERVER_FOLDER"/cfg/shiny-server.conf

#copia aplicação
cp -u index.html "$R_SERVER_FOLDER"/apps

# Start Shiny-server
echo -e ".... Starting \e[93mShiny Server\e[0m"
. start_ShinyBr.sh

sleep 5s
    
# Start portainer_app
echo -e ".... Starting \e[94mPortainer.io\e[0m"
docker run -d --name portainer_app --restart unless-stopped \
    --dns="$R_DNS" \
    -p "$R_PORTAINER_EX_PORT":9000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /opt/portainer/data:/data \
    portainer/portainer

sleep 3s    

# Start filebrowser_app
echo -e ".... Starting \e[95mFile Browser\e[0m"
docker run -d --name filebrowser_app --restart unless-stopped \
    --dns="$R_DNS" \
    -p "$R_FILEBROWSER_EX_PORT":80 \
    -v "$R_FILEBROWSER_FOLDER"/config.json:/config.json \
    -v "$R_FILEBROWSER_FOLDER"/etc:/etc \
    -v "$R_SERVER_FOLDER"/apps:/srv/apps \
    -v "$R_SERVER_FOLDER"/log:/srv/log \
    filebrowser/filebrowser

sleep 3s        
    
# Start samba_app - Please change the password
echo -e ".... Starting \e[92mSamba Server\e[0m"

ARQ1="start_Samba.sh"
ARQ2=mp."$ARQ1"

if [ -f "$ARQ2" ]; then
    # run other
    . "$ARQ2"
else
    # run default
    . "$ARQ1"
fi
echo -e "MSG FILE: \e[91m"$ARQ_MSG"\e[0m"

    
sleep 3s

# Show all containers
echo -e "\e[44mAll Containers !!! \e[0m"
docker ps