list.of.packages <- c("shiny", "readr", "DT",
				"shinymaterial", "tidyverse", "flexdashboard",
				"sf", "rgeos", "rgdal", "readxl", "rmapshaper", "leaflet",
				"shinythemes", "Cairo", "rAmCharts", "forcats", "formattable",
				"gridExtra", "highcharter", "htmltools", "htmlwidgets", "knitr",
				"kableExtra", "leaflet.extras", "lubridate", "pacman", "purrr", "RColorBrewer",
				"reshape2", "stringr", "broom", "crosstalk", "devtools", "extrafont", "formatR",
				"gapminder", "ggmap", "ggthemes", "haven","htmlwidgets", "httpuv",
				"leaflet.minicharts", "maptools", "plotly","reshape", "reshape", "rmarkdown",
				"scales", "tictoc", "tidyr", "tmap", "tmaptools", "viridis", "viridisLite",
				"xtable","brazilmaps")

#v.1.1
list.of.packages <- c(list.of.packages, 
				"dplyr","shiny", 'shinydashboard',
				'openxlsx', 'DBI', 'RMariaDB', 'shinyjs', 'pool')
				
#v.1.2

list.of.packages <- c(list.of.packages, 'RPostgres')

#v.2.0

list.of.packages <- c(list.of.packages, 'shinyalert', 'RCurl')

install('devtools')
library('devtools')

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos='http://cran.us.r-project.org')

devtools::install_github('dmslabsbr/dtedit2')
devtools::install_github('dmslabsbr/shinyldap')
