FROM rocker/shiny:4.1.0
LABEL maintainer="danielmiele@mpgo.mp.br"
# system libraries of general use
# v. 4.0 - 09/06/2021

ARG def_nameserver=8.8.8.8
#ARG def_search=intranet.mpgo

RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    apt-get update && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
    sudo \
    pandoc pandoc-citeproc \
    libcurl4-gnutls-dev libcairo2-dev libxt-dev libssl-dev libssh2-1-dev libxml2-dev \
    default-jre default-jdk r-cran-rjava \
    locales locales-all && \
    echo "\e[94m*  LOCALE  *\e[0m" && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "pt_BR.UTF8 UTF-8" >> /etc/locale.gen && \
    echo "pt_BR.ISO-8859-1 ISO-8859-1" >> /etc/locale.gen && \
    locale-gen --purge && \ 
    update-locale && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \	
    apt-get install -y --no-install-recommends gdebi-core wget nano  && \
    echo -e "\e[94m*  Basic shiny functionality  *\e[0m" && \
    R -e "install.packages(c('shiny', 'rmarkdown', \
    'shinymaterial', 'tidyverse', 'readr', 'DT'))"  && \
    echo -e "\e[94m*  Novos pacotes  *\e[0m" && \
    apt-get install -y --no-install-recommends \
    libprotobuf-dev libv8-dev libudunits2-dev libjq-dev libgdal-dev protobuf-compiler  && \
    apt-get clean && \
    R -e "install.packages(c('rmapshaper', 'flexdashboard', 'leaflet', \
    'shinythemes', 'Cairo', 'rAmCharts', 'formattable', \
    'gridExtra', 'highcharter', 'htmlwidgets', \
    'knitr', 'kableExtra', 'leaflet.extras', \
    'pacman', 'devtools', 'extrafont', \
    'formatR', 'gapminder', 'ggmap', \
    'ggthemes', 'leaflet.minicharts', 'plotly', \
    'reshape', 'reshape2', 'tictoc', \
    'tmap', 'tmaptools', 'viridis','brazilmaps'))" && \
    echo "\e[94m* Pacotes R 14/05/2020\e[0m" && \
    R -e "install.packages(c('shinydashboard', 'openxlsx', \
    'RMariaDB', 'shinyjs', 'pool', 'shinyalert', 'RCurl'))" && \
    echo -e "\e[94m* Pacotes R 14/05/2020\e[0m" && \
    R -e "install.packages(c('sqldf'))" && \
    echo -e "\e[94m* Pacotes R 10/06/2021\e[0m" && \
    R -e "install.packages('rJava', type = 'source', INSTALL_opts='--merge-multiarch')" && \
    R -e "install.packages(c('xlsx'))" && \
    echo -e "\e[94m*  Pacotes dmslabsbr  *\e[0m" && \
    R -e "devtools::install_github('dmslabsbr/dtedit2')" && \
    R -e "devtools::install_github('dmslabsbr/shinyldap')" && \
    echo -e "\e[94m* Limpando filesystem \e[0m" && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get autoclean -y

# Config
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}"
ENV R_VERSION='4.0.0'
ENV TERM='xterm'
ENV LC_ALL pt_BR.utf8
ENV LANG pt_BR.utf8
ENV LANGUAGE pt_BR.utf8
ENV TZ="America Sao_Paulo"

COPY Rprofile.site /usr/lib/R/etc/Rprofile.site
COPY Rprofile.site /usr/local/lib/R/etc/Rprofile.site
COPY shiny-server.conf /etc/shiny-server
COPY app.R /srv/shiny-server/apps
COPY index.html /srv/shiny-server/apps
RUN apt-get clean
EXPOSE 3838
CMD ["exec", "shiny-server"]
#CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/apps', port = 3838, quiet = FALSE)"]