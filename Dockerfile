FROM rocker/shiny
MAINTAINER Daniel "danielmiele@mpgo.mp.br"
# system libraries of general use

ARG def_nameserver=8.8.8.8

RUN  echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    apt-get update && apt-get install -y --no-install-recommends \
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
	apt-get clean

#LOCALE
ENV LC_ALL pt_BR.utf8
ENV LANG pt_BR.utf8
ENV LANGUAGE pt_BR.utf8
ENV TZ="America Sao_Paulo"
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    sudo locale-gen pt_BR pt_BR.utf8 pt_BR.iso88591 \
      Portuguese_Brazil Portuguese_Brazil.1252 && \
    sudo update-locale && \
    sudo dpkg-reconfigure locales  && \
	apt-get clean

#Nameserver
RUN  echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    apt-get update && \ 
	apt-get install -y sudo gdebi-core wget  && \
	apt-get clean

# basic shiny functionality
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    R -e "install.packages(c('shiny', 'rmarkdown', \
    'shinymaterial', 'tidyverse', 'readr', 'DT'))"  && \
	apt-get clean

# Novos pacotes
RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    apt-get install -y --no-install-recommends \
    libprotobuf-dev \
    libv8-dev \
    libudunits2-dev \
    libjq-dev \
    libgdal-dev \
    protobuf-compiler  && \
	apt-get clean

RUN echo "nameserver ${def_nameserver}" > /etc/resolv.conf && \
    echo "search intranet.mpgo" >> /etc/resolv.conf && \
    R -e "install.packages(c('rmapshaper', 'flexdashboard', 'leaflet', \
    'shinythemes', 'Cairo', 'rAmCharts', 'formattable', \
    'gridExtra', 'highcharter', 'htmlwidgets', \
    'knitr', 'kableExtra', 'leaflet.extras', \
    'pacman', 'devtools', 'extrafont', \
    'formatR', 'gapminder', 'ggmap', \
    'ggthemes', 'leaflet.minicharts', 'plotly', \
    'reshape', 'reshape', 'tictoc', \
    'tmap', 'tmaptools', 'viridis'))"
	&& \
	apt-get clean

# Config
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}"
ENV R_VERSION='3.5.1'
ENV TERM='xterm'

# copy the app to the image
#RUN mkdir /root/pgj
#COPY pgj /root/pgj

COPY Rprofile.site.txt /usr/lib/R/etc/Rprofile.site
COPY index.html /root
RUN apt-get clean
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/root')"]
