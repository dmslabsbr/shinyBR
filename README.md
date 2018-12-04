# shinyBR

Imagem Docker de um Servidor R Shiny baseada na imagem rocker/shiny

Servidor padronizado para a lingua portuguesa, Brasil.

Inclui os comandos para a pré-instalação dos seguintes pacotes:

list.of.packages <- c("shiny",

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


## Para configurar o locale da sua aplicação use um dos comandos R abaixo. 

Sys.setlocale(category = "LC_ALL", locale = "pt_BR.iso88591")

Sys.setlocale(category = "LC_ALL", locale = "pt_BR.utf8")

Sys.setlocale(category = "LC_ALL", locale = "pt_BR")
