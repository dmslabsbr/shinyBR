#!/bin/bash

# Container: https://github.com/dperson/samba

ARQ_MSG="Default Samba file"          # File identification 
docker run -d --name samba_app --restart unless-stopped \
    --dns="$R_DNS" \
    -p 139:139 \
    -p 445:445 \
    -v "$R_SERVER_FOLDER"/app0:/srv/root_dir \
    -v "$R_SERVER_FOLDER"/log:/srv/log \
    -v "$R_SERVER_FOLDER"/app1:/srv/dir_a \
    -v "$R_SERVER_FOLDER"/app2:/srv/dir_b \
    -v "$R_SERVER_FOLDER"/app3:/srv/dir_c \
    -v "$R_SERVER_FOLDER"/appTst:/srv/dir_t \
    dperson/samba -u "user1;password" \
    -s "Share-1;/srv;yes;no;no;all;user1;user1;'Pasta R Shiny Server'" \
    -u "user2;password" \
    -s "Share-2;/srv/root_dir;yes;no;yes;all;user2;user2;'Pasta R Shiny Server User2'" \
    -u "user3;password" \
    -s "Share-3;/srv/dir_c;yes;no;no;user3;user3;user3;'Pasta R Shiny Server user3'" \
    -u "outros;Routros" \
    -s "R-Outros;/srv/dir_c;yes;no;yes;all;outros;outros;'Pasta R Shiny Server Outros'" \
    -s "R-Testes;/srv/dir_t;yes;no;yes;all;all;all;'Pasta R Shiny Server Testes'"