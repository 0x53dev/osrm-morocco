#!/bin/bash

docker run -d -p 5000:5000 --name osrm-api ioteam/osrm-morocco-docker:latest osrm Casablanca