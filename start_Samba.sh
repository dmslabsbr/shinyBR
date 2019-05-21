#!/bin/bash

# https://github.com/dperson/samba
docker run -d --name samba_app --restart unless-stopped \
    --dns="$R_DNS" \
    -p 139:139 \
    -p 445:445 \
    -v "$R_SERVER_FOLDER"/apps:/srv/apps \
    -v "$R_SERVER_FOLDER"/log:/srv/log \
    -v "$R_SERVER_FOLDER"/app1:/srv/app1 \
    -v "$R_SERVER_FOLDER"/app2:/srv/app2 \
    -v "$R_SERVER_FOLDER"/app3:/srv/app3 \
    -v "$R_SERVER_FOLDER"/appTst:/srv/appTst \
    dperson/samba -u "\"$SambaU0;$SambaP0" \
    -s "\"$SambaS0;/srv;yes;no;no;all;$SambaU0;$SambaU0;'$SambaM0'"\" \
    -u "\"$SambaU1;$SambaP1"\" \
    -s "\"$SambaS1;/srv/app1;yes;no;yes;all;$SambaU1;$SambaU1;'$SambaM1'"\" \
    -u "\"$SambaU2;$SambaP2"\" \
    -s "\"$SambaS2;/srv/app2;yes;no;no;$SambaU2;$SambaU2;$SambaU2;'$SambaM2'"\" \
    -u "\"$SambaU3;$SambaP3"\" \
    -s "\"$SambaS3;/srv/app3;yes;no;yes;all;$SambaU3;$SambaU3;'$SambaM3'"\" \
    -s "\"R-Test;/srv/appTst;yes;no;yes;all;all;all;'Pasta R Shiny Server Testes'"\"