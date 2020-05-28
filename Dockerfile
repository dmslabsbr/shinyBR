FROM rocker/shiny
LABEL maintainer="danielmiele@mpgo.mp.br"
# system libraries of general use
# v. 2.0 - 28/05/2020

ARG def_nameserver=8.8.8.8
ARG def_search=intranet.mpgo

RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends \
    sudo \
    pandoc pandoc-citeproc \
    libcurl4-gnutls-dev libcairo2-dev libxt-dev libssl-dev libssh2-1-dev libxml2-dev \
    locales locales-all && \
    echo "\e[94m*  LOCALE  *\e[0m" && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "pt_BR.UTF8 UTF-8" >> /etc/locale.gen && \
    echo "pt_BR.ISO-8859-1 ISO-8859-1" >> /etc/locale.gen && \
    locale-gen --purge && \ 
    update-locale && \
    apt-get install -y --no-install-recommends gdebi-core wget nano  && \
    echo "\e[94m*  Basic shiny functionality  *\e[0m" && \
    R -e "install.packages(c('shiny', 'rmarkdown', \
    'shinymaterial', 'tidyverse', 'readr', 'DT'))"  && \
    echo "\e[94m*  Novos pacotes  *\e[0m" && \
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
    'reshape', 'reshape', 'tictoc', \
    'tmap', 'tmaptools', 'viridis','brazilmaps'))" && \
    R -e "install.packages(c('shinydashboard', 'openxlsx', 'RMariaDB', 'shinyjs', 'pool', 'shinyalert', 'RCurl'))" && \
    echo "\e[94mPacotes R 14/05/2020\e[0m" && \
    R -e "install.packages(c('sqldf'))" && \
    R -e "devtools::install_github('dmslabsbr/dtedit2')" && \
    R -e "devtools::install_github('dmslabsbr/shinyldap')"


# Config
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}"
ENV R_VERSION='4.0.0'
ENV TERM='xterm'
ENV LC_ALL pt_BR.utf8
ENV LANG pt_BR.utf8
ENV LANGUAGE pt_BR.utf8
ENV TZ="America Sao_Paulo"

# copy the app to the image
#RUN mkdir /root/pgj
#COPY pgj /root/pgj

COPY Rprofile.site.txt /usr/lib/R/etc/Rprofile.site
COPY Rprofile.site.txt /usr/local/lib/R/etc/Rprofile.site
COPY index.html /root
RUN apt-get clean
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/root')"]
