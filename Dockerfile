FROM osrm/osrm-backend as builder
WORKDIR /data
RUN wget http://download.geofabrik.de/africa/morocco-latest.osm.pbf
RUN /usr/local/bin/osrm-extract -p /opt/car.lua morocco-latest.osm.pbf
RUN /usr/local/bin/osrm-partition morocco-latest.osrm
RUN /usr/local/bin/osrm-customize morocco-latest.osrm
RUN /usr/local/bin/osrm-contract morocco-latest.osrm
RUN rm morocco-latest.osm.pbf

FROM osrm/osrm-backend  
WORKDIR /data/
EXPOSE 5000
COPY --from=builder /data .
CMD ["osrm-routed", "--max-table-size 8000", "--algorithm ch /data/morocco-latest.osrm"]
