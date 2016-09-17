#!/bin/bash
DATA_PATH=${DATA_PATH:="/osrm-data"}

_sig() {
  kill -TERM $child 2>/dev/null
}

if [ "$1" = 'osrm' ]; then
  trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT

  #./osrm-extract $DATA_PATH/morocco-latest.osm.pbf
  #./osrm-contract $DATA_PATH/morocco-latest.osrm

  #./osrm-routed $DATA_PATH/morocco-latest.osrm --max-table-size 8000 &
  
  ./osrm-datastore $DATA_PATH/osrm-data/morocco-latest.osrm
  
  child=$!
  wait "$child"
else
  exec "$@"
fi