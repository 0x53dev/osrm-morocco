FROM node:6.6.0
MAINTAINER Younes Benaomar <younes@interactive-object.com>

# Let the container know that there is no TTY
ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages for proper system state
RUN apt-get -y update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libboost-all-dev \
    libbz2-dev \
    libstxxl-dev \
    libstxxl-doc \
    libstxxl1 \
    libtbb-dev \
    libxml2-dev \
    libzip-dev \
    lua5.1 \
    liblua5.1-0-dev \
    libluabind-dev \
    libluajit-5.1-dev \
    pkg-config

RUN mkdir -p /osrm
COPY osrm-data /osrm-data

WORKDIR /opt/osrm

RUN curl --silent -L https://github.com/Project-OSRM/osrm-backend/archive/v5.3.2.tar.gz -o v5.3.2.tar.gz \
 && tar xzf v5.3.2.tar.gz \
 && mv osrm-backend-5.3.2 /osrm-src \
 && cmake /osrm-src \
 && make \
 && mv /osrm-src/profiles/car.lua profile.lua \
 && mv /osrm-src/profiles/lib/ lib \
 && echo "disk=/tmp/stxxl,25000,syscall" > .stxxl \
 && rm -rf /osrm-src


RUN export PATH=/opt/osrm/bin:${PATH}
RUN export PKG_CONFIG_PATH=/opt/osrm/lib/pkgconfig
RUN pkg-config libosrm --variable=prefix
# if boost headers are in a custom location give a hint about that
# here we assume the are in `/opt/boost`
#RUN export CXXFLAGS="-I/opt/boost/include"
RUN git clone https://github.com/Project-OSRM/node-osrm.git && npm install --build-from-source -g


# Cleanup --------------------------------

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# Publish --------------------------------

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5000