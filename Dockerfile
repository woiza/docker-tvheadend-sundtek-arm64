FROM woiza/docker-baseimage-ubuntu-arm64
MAINTAINER woiza
#forked from MAINTAINER firsttris <info@teufel-it.de>

RUN [ "cross-build-start" ]
# Install dependencies
RUN apt-get update -qq \ 
 && apt-get install -qqy apt-transport-https software-properties-common bzip2 libavahi-client3 libav-tools xmltv wget udev gnupg2

# Add key and tvheadend repository
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
#RUN apt-add-repository "https://dl.bintray.com/tvheadend/deb ${tvh_release}"

RUN apt-add-repository ppa:mamarley/tvheadend-git-stable

# Install tvheadend
RUN apt-get update -qq \ 
 && apt-get install -qqy tvheadend

# Install Sundtek DVB Driver
RUN wget http://www.sundtek.de/media/sundtek_netinst.sh \
 && chmod 777 sundtek_netinst.sh \
 && ./sundtek_netinst.sh

# Add Basic config
ADD config /config/

# Timezone
RUN echo "Europe/Berlin" > /etc/timezone

# Create Locales
ENV LANG="de_DE.UTF-8"
RUN apt-get update -qqy && apt-get install -qqy locales && $_apt_clean \
 && grep "$LANG" /usr/share/i18n/SUPPORTED >> /etc/locale.gen && locale-gen \
 && update-locale LANG=$LANG

# Configure the hts user account and it's folders
RUN groupmod -o -g 9981 hts \
 && usermod -o -u 9981 -a -G video -d /config hts \
 && install -o hts -g hts -d /config /recordings

# Launch script
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN [ "cross-build-end" ]

# Default container settings
VOLUME /config /recordings /picons
EXPOSE 9981 9982
ENTRYPOINT ["/entrypoint.sh"]
