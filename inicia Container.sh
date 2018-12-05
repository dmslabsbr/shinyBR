#Criar diretórios /srv/shiny-server
#                 /srv/shiny-server/log
#                 /srv/shiny-server/cfg
#                 /srv/shiny-server/apps
#Copiar shiny-server.conf para /srv/shiny-server/cfg


docker run -d --name shiny-br --restart unless-stopped -p 3839:3838 \
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
    dms/shinybr /usr/bin/shiny-server.sh
