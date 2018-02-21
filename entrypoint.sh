#!/bin/bash -x

# Set the uid:gid to run as
[ "$PUID" ] && usermod  -o -u "$PUID" hts
[ "$PGID" ] && groupmod -o -g "$PGID" hts

# Start Sundtek
/opt/bin/mediaclient --start

# Start tvheadend
/usr/bin/tvheadend -C -u hts -g hts -c /config
