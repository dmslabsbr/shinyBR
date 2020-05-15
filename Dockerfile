FROM rocker/shiny
LABEL maintainer="danielmiele@mpgo.mp.br"
# system libraries of general use
# v. 2.0 - 14/05/2020

ARG def_nameserver=8.8.8.8
ARG def_search=intranet.mpgo

RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    apt update && apt install -y --no-install-recommends \
    apt-utils \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    locales \
    locales-all && \
	apt clean

#LOCALE
ENV LC_ALL pt_BR.utf8
ENV LANG pt_BR.utf8
ENV LANGUAGE pt_BR.utf8
ENV TZ="America Sao_Paulo"
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    sudo locale-gen pt_BR pt_BR.utf8 pt_BR.iso88591 \
      Portuguese_Brazil Portuguese_Brazil.1252 && \
    sudo update-locale && \
    sudo dpkg-reconfigure locales  && \
	apt clean

#Nameserver
RUN  echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    apt update && \ 
	apt install -y sudo gdebi-core wget nano  && \
	apt clean

# basic shiny functionality
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    R -e "install.packages(c('shiny', 'rmarkdown', \
    'shinymaterial', 'tidyverse', 'readr', 'DT'))"  && \
	apt clean

# Novos pacotes
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    apt-get install -y --no-install-recommends \
    libprotobuf-dev \
    libv8-dev \
    libudunits2-dev \
    libjq-dev \
    libgdal-dev \
    protobuf-compiler  && \
	apt clean

RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    R -e "install.packages(c('rmapshaper', 'flexdashboard', 'leaflet', \
    'shinythemes', 'Cairo', 'rAmCharts', 'formattable', \
    'gridExtra', 'highcharter', 'htmlwidgets', \
    'knitr', 'kableExtra', 'leaflet.extras', \
    'pacman', 'devtools', 'extrafont', \
    'formatR', 'gapminder', 'ggmap', \
    'ggthemes', 'leaflet.minicharts', 'plotly', \
    'reshape', 'reshape', 'tictoc', \
    'tmap', 'tmaptools', 'viridis','brazilmaps'))" && \
    apt clean
    
# Pacotes R 13/12/2019
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    R -e "install.packages(c('shinydashboard', 'openxlsx', 'RMariaDB', 'shinyjs', 'pool', 'shinyalert', 'RCurl'))" && \
    apt clean

# Pacotes R 14/05/2020
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search ${def_search}" >> /etc/resolv.conf && \
    R -e "install.packages(c('sqldf'))" && \
    R -e "devtools::install_github('dmslabsbr/dtedit2'" && \
    R -e "devtools::install_github('dmslabsbr/shinyldap'" && \
    apt clean



# Config
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}"
ENV R_VERSION='3.6.0'
ENV TERM='xterm'

# copy the app to the image
#RUN mkdir /root/pgj
#COPY pgj /root/pgj

COPY Rprofile.site.txt /usr/lib/R/etc/Rprofile.site
COPY Rprofile.site.txt /usr/local/lib/R/etc/Rprofile.site
COPY index.html /root
RUN apt clean
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/root')"]
