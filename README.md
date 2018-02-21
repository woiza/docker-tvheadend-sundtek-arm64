#### tvheadend-sundtek-docker
:tv: docker container for tvheadend with sundtek dvb adapter

[![Docker Automated buil](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/clemensvb/tvheadend-sundtek-docker/)



Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, ISDB-T, IPTV, SAT>IP and HDHomeRun as input sources.  

[tvheadend.org](https://tvheadend.org/)

The 'unstable' version of tvheadend is used. 
15 Oct 2017: `Version 4.3-XXXX`

Offical repository as source:   
https://bintray.com/tvheadend/deb/tvheadend/

### Pull
```bash
docker pull docker pull clemensvb/tvheadend-sundtek-docker
```

### Run:
It dont passes the sundtek adapter because it is not installed on the host.
Webinterface user and password: admin/admin - DONT FORGET TO CHANGE THIS.

```bash
docker run \
--name="tvheadend" \
--restart=always \
--net=bridge \
-v /media/8tb.wd.red/recordings/:/recordings \
-v /home/docker/tvheadend/:/config \
-v /home/docker/picons/:/picons \
-e TZ=<timezone> \
-e PUID=<UID> -e PGID=<GID> \
-p 9981:9981 \
-p 9982:9982 \
--device=/dev/dvb/* \
-d woiza/tvheadend-sundtek-docker
```

```bash
docker run \
--name="tvheadend" \
--restart=always \
--privileged \
--net=bridge \
-v /media/8tb.wd.red/recordings/:/recordings \
-v /home/docker/tvheadend/:/config \
-v /home/docker/picons/:/picons \
-v /etc/localtime:/etc/localtime:ro \
-p 9981:9981 \
-p 9982:9982 \
--device=/dev/dvb/* \
-d tristanteu/tvheadend-sundtek-docker
```

### Important Notice - First Start
Don't install sundtek driver on your host.

### Build
```bash

git clone https://github.com/clemensvb/tvheadend-sundtek-docker.git
cd tvheadend-sundtek-docker
docker build -t clemensvb/tvheadend-sundtek-docker .
```

### Picons:
https://github.com/picons/picons-source

## License
See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
