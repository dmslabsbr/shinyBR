#!/bin/bash

# Before you start you must create the following directories
#                 /srv/shiny-server
#                 /srv/shiny-server/log
#                 /srv/shiny-server/cfg
#                 /srv/shiny-server/apps  # Principal
#                 /srv/shiny-server/app1  # para outras áreas
#                 /srv/shiny-server/app2  # para outras áreas
#                 /srv/shiny-server/app3  # para outras áreas
# Copy shiny-server.conf to /srv/shiny-server/cfg


docker run -d --name shiny-br --restart unless-stopped -p "$R_SERVER_EX_PORT":3838 \
    --dns="$R_DNS" \
    -e PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' \
    -e R_VERSION='3.6.1' \
    -e LC_ALL='pt_BR.UTF-8' \
    -e LANG='pt_BR.UTF-8' \
    -e TERM='xterm' \
    -e TZ='America Sao_Paulo' \
    -v "$R_SERVER_FOLDER"/app0/:/srv/shiny-server/root \
    -v "$R_SERVER_FOLDER"/app1/:/srv/shiny-server/a \
    -v "$R_SERVER_FOLDER"/app2/:/srv/shiny-server/b \
    -v "$R_SERVER_FOLDER"/app3/:/srv/shiny-server/c \
    -v "$R_SERVER_FOLDER"/appTst/:/srv/shiny-server/tst \
    -v "$R_SERVER_FOLDER"/log/:/var/log/shiny-server/ \
    -v "$R_SERVER_FOLDER"/cfg:/etc/shiny-server \
    dmslabsbr/shinybr /usr/bin/shiny-server.sh
