#!/bin/bash
# Container: https://github.com/dperson/samba

ARQ_MSG="Default Samba file"          # File identification 
docker run -d --name samba_app --restart always \
    --dns="$R_DNS" \
    -p 139:139 \ 
    -p 445:445 \
    -v /srv/shiny-server/apps:/srv/apps \
    -v /srv/shiny-server/log:/srv/log \
    -v /srv/shiny-server/app1:/srv/app1 \
    -v /srv/shiny-server/app2:/srv/app2 \
    -v /srv/shiny-server/app3:/srv/app3 \
    -v /srv/shiny-server/appTst:/srv/appTst \
    dperson/samba -u "user1;password" \
    -s "Share-1;/srv;yes;no;no;all;user1;user1;'Pasta R Shiny Server'" \
    -u "user2;password" \
    -s "Share-2;/srv/app1;yes;no;yes;all;user2;user2;'Pasta R Shiny Server User2'" \
    -u "user3;password" \
    -s "Share-3;/srv/app2;yes;no;no;user3;user3;user3;'Pasta R Shiny Server user3'" \
    -u "outros;Routros" \
    -s "R-Outros;/srv/app3;yes;no;yes;all;outros;outros;'Pasta R Shiny Server Outros'" \
    -s "R-Testes;/srv/appTst;yes;no;yes;all;all;all;'Pasta R Shiny Server Testes'"