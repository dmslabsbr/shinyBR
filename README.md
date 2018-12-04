# shinyBR  
  
Imagem Docker de um Servidor R Shiny baseada na imagem [rocker/shiny](https://github.com/rocker-org/shiny).  
Servidor padronizado para a lingua portuguesa, Brasil.  
Inclui os comandos para a pré-instalação dos seguintes pacotes:  
  
**list.of.packages** <- c("shiny",  
 "readr", "DT", "shinymaterial", "tidyverse", "flexdashboard",  
  "sf", "rgeos", "rgdal", "readxl", "rmapshaper", "leaflet",  
  "shinythemes", "Cairo", "rAmCharts", "forcats", "formattable",  
 "gridExtra", "highcharter", "htmltools", "htmlwidgets", "knitr",  
 "kableExtra", "leaflet.extras", "lubridate", "pacman", "purrr",  
 "RColorBrewer", "reshape2", "stringr", "broom", "crosstalk",  
 "devtools", "extrafont", "formatR", "gapminder", "ggmap",   
 "ggthemes", "haven","htmlwidgets", "httpuv", "leaflet.minicharts",  
 "maptools", "plotly","reshape", "reshape", "rmarkdown",  
 "scales", "tictoc", "tidyr", "tmap", "tmaptools", "viridis",  
 "viridisLite", "xtable")  

## Comando para gerar a imagem - Arquivo: `docker build.sh`  

```
docker build --build-arg def_nameserver=**8.8.8.8** -t dms/shinybr .  
```
### Se necessário substitua o ip do servidor de nomes por outro.  

1 - Primeiro é necessário criar no servidor os diretórios onde ficarão armazenadas os __apps, configurações e logs__.  

- **Criar diretórios:**
- /srv/shiny-server
- /srv/shiny-server/log
- /srv/shiny-server/cfg
- /srv/shiny-server/apps

## Comando para iniciar o container - Arquivo: `inicia Container.sh`

```
docker run -d --name shiny-br --restart unless-stopped -p **3839:3838** \
    --dns=**8.8.8.8** \
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
```
### Caso necessário substitua:
#### 1 - A porta **3839** por outra.
#### 2 - O dns **8.8.8.8** por outro.

## Caso necessário, configure o locale da sua aplicação, colocando um dos comandos abaixo na 1a linha do seu código. 

- Sys.setlocale(category = "LC_ALL", locale = "pt_BR.iso88591")
- Sys.setlocale(category = "LC_ALL", locale = "pt_BR.utf8")
- Sys.setlocale(category = "LC_ALL", locale = "pt_BR")


## URL do projeto no Docker Hub: [dmslabsbr/shinybr](https://hub.docker.com/r/dmslabsbr/shinybr)
