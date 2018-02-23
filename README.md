docker volume create --name tvheadend-data

INSTALL SUNDTEK DRIVER ON HOST! (or use privileged)


docker run -d \
  --name=tvheadend-sundtek \
  --net=net-tv \
  -v tvheadend-sundtek-data:/config \
  -v /home/woiza/tvheadend-recordings:/recordings \
  -v /home/woiza/picons:/picons \
  -e PGID=1001 -e PUID=1001  \
  -p 9981:9981 \
  -p 9982:9982 \
  -v /opt/bin:/opt/bin \
  --device=/dev/dvb:/dev/dvb \
  --device=/dev/bus/usb/004:/dev/bus/usb/004 \
  --restart always \
  woiza/tvheadend-sundtek-docker
