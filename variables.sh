# Variables
ARQ_MSG="Default FILE"                      # File identification 
R_DNS="8.8.8.8"                             # DNS Server
R_SERVER_FOLDER="/srv/shiny-server"         # External R Server folder
R_SERVER_EX_PORT=3839                       # External R Server port
R_PORTAINER_EX_PORT=9001                    # External Portainer port
R_FILEBROWSER_EX_PORT=9002                  # External Portainer port
R_FILEBROWSER_FOLDER="/srv/filebrowser"     # External FileBrowser folder
# SAMBA configuration
SambaU1="user1"
SambaP1="password1"
SambaU2="user2"
SambaP2="password2"
SambaU3="user3"
SambaP3="password3"
SambaU0="user0"
SambaP0="password0"
SambaS1="R-Share-1"
SambaS2="R-Share-2"
SambaS3="R-Share-3"
SambaS0="R-Share-4"
SambaM1="Folder R-Server $SambaS1 user: $SambaU1"
SambaM2="Folder R-Server $SambaS2 user: $SambaU2"
SambaM3="Folder R-Server $SambaS3 user: $SambaU3"
SambaM0="Folder R-Server $SambaS0 user: $SambaU0"

echo $ARQ_MSG
