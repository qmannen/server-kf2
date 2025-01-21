FROM debian:latest
#steamcmd/steamcmd:debian

ARG URL_STEAMCMD
ARG CONTAINER_USER
ENV CONTAINER_USER=${CONTAINER_USER}
ARG CONTAINER_DIR_HOME
ENV CONTAINER_DIR_HOME=${CONTAINER_DIR_HOME}
ARG CONTAINER_DIR_SERVICE
ENV CONTAINER_DIR_SERVICE=${CONTAINER_DIR_SERVICE}

ARG KF2_GAME_PORT
ENV KF2_GAME_PORT=${KF2_GAME_PORT}
ARG KF2_QUERY_PORT
ENV KF2_QUERY_PORT=${KF2_QUERY_PORT}
ARG KF2_WEBADMIN_PORT
ENV KF2_WEBADMIN_PORT=${KF2_WEBADMIN_PORT}
ARG KF2_ADMIN_PASSWORD
ENV KF2_ADMIN_PASSWORD=${KF2_ADMIN_PASSWORD}
ARG KF2_GAME_DIFFICULTY
ENV KF2_GAME_DIFFICULTY=${KF2_GAME_DIFFICULTY}
ARG KF2_GAME_LENGTH
ENV KF2_GAME_LENGTH=${KF2_GAME_LENGTH}
ARG KF2_GAME_MODE
ENV KF2_GAME_MODE=${KF2_GAME_MODE}
ARG KF2_GAME_PLAYER_COUNT
ENV KF2_GAME_PLAYER_COUNT=${KF2_GAME_PLAYER_COUNT}
ARG KF2_MAP_NAME
ENV KF2_MAP_NAME=${KF2_MAP_NAME}

#ENV HOME="${CONTAINER_DIR_HOME}"

#steam port
EXPOSE 20560/udp
#game port
EXPOSE 7777/udp
#web admin port
EXPOSE 8080/tcp
#query port - master server coms, to show up in server browser
EXPOSE 27015/udp

RUN dpkg --add-architecture i386 \
 && apt update -y \
 && apt upgrade -y  \
 && apt install -y --no-install-recommends --no-install-suggests \
	sudo \
	curl \
	nano \
	libcurl4 \
	libc6:i386 \
	libstdc++6:i386 \
	lib32gcc-s1 \
	lib32z1 \
	libcurl3-gnutls:i386 \
        libcurl4-gnutls-dev:i386 \
	libcurl3-gnutls:i386 \
	ca-certificates \
	locales \
 && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Install steamcmd
RUN mkdir -p ${CONTAINER_DIR_HOME}/steamcmd \
    && curl -o /tmp/steamcmd.tar.gz "${URL_STEAMCMD}" \
    && tar -xvzf /tmp/steamcmd.tar.gz -C ${CONTAINER_DIR_HOME}/steamcmd \
    && rm -rf /tmp/*

# Remove curl and clean-up apt
RUN apt-get remove --purge -y curl && \
        apt-get clean autoclean && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg} /var/{cache,log}

RUN useradd -d ${CONTAINER_DIR_HOME} -m -s /bin/bash ${CONTAINER_USER}
RUN mkdir -p ${CONTAINER_DIR_SERVICE}
RUN mkdir -p ${CONTAINER_DIR_HOME}/scripts
RUN mkdir -p ${CONTAINER_DIR_HOME}/Steam/linux32
RUN mkdir -p ${CONTAINER_DIR_HOME}/Steam/logs
RUN mkdir -p ${CONTAINER_DIR_HOME}/.steam/sdk32
RUN ln -s ${CONTAINER_DIR_HOME}/Steam/linux32/steamclient.so ${CONTAINER_DIR_HOME}/.steam/sdk32/steamclient.so

ADD download.sh ${CONTAINER_DIR_HOME}/scripts/download.sh
ADD run.sh ${CONTAINER_DIR_HOME}/scripts/run.sh
ADD start.sh ${CONTAINER_DIR_HOME}/scripts/start.sh

RUN chown -R ${CONTAINER_USER}:${CONTAINER_USER} ${CONTAINER_DIR_HOME}
WORKDIR ${CONTAINER_DIR_HOME}
ENTRYPOINT ["/home/services/scripts/run.sh"]
