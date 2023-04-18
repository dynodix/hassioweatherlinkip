#!/usr/bin/with-contenv bashio
#---/bin/bash 
set -e
echo "Weatherlink IP started"
WLIP=$(bashio::config 'weatherlinkip')
echo "Device IP = $WLIP "
echo $WLIP > /deviceip
/usr/bin/perl /weatherserver.pl daemon -l http://*:8222
#while true; do sleep 30; done;
