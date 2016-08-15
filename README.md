# Dockerfile for OSRM Backend
This container run [osrm-backend](https://github.com/Project-OSRM/osrm-backend) project.
Open Source Routing Machine (OSRM) Docker Image [\[Docker Hub\]](https://hub.docker.com/r/interactiveobject/osrm-morocco-docker/) with Morocco OSM preloaded.

## Installation

1. Install [Docker](https://www.docker.com/)

2. Manual deploy (optional).

  Pull automated build from Docker Hub:
  ```
  $ docker pull interactiveobject/osrm-morocco-docker
  ```
  or build from GitHub:
  ```
  $ docker build -t="interactiveobject/osrm-morocco-docker" github.com/InteractiveObject/osrm-morocco-docker
  ```
  or you can clone & build:  
  ```
  $ git clone https://github.com/InteractiveObject/osrm-morocco-docker.git  
  $ docker build -t="interactiveobject/osrm-morocco-docker" osrm-morocco-docker/
  ```

## Usage
Run it:  
```
docker run -d -p 5000:5000 interactiveobject/osrm-morocco-docker:latest osrm Casablanca
```  

Explanation:  
- `-d` - run container in background and print container ID 
- `-p 5000:5000` - publish a container port to host
- `osrm` - go via entrypoint script, w/o osrm keyword - classic mode
- `label` - your label of OSM data


## License

[Interactive Object](https://interactive-object.com) The content of this project itself is licensed under the Creative Commons Attribution 3.0 license, and the underlying source code used to format and display that content is licensed under the MIT license.
