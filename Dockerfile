FROM debian:latest
#steamcmd/steamcmd:debian

ARG STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
ARG INPUT_USER="services"
ARG INPUT_HOME_DIR="/home/services"

ENV HOME="${INPUT_HOME_DIR}"
ENV ADMIN="admin"
ENV ADMIN_PASSWORD="admin"
ENV START_MAP="kf-bioticslab"
ENV MAX_PLAYERS=6
ENV DIFFICULTY=0
ENV ENABLE_WEBADMIN=true
#Options: Survival, Versus, Weekly, Endless
ENV GAMEMODE=Survival 

#Debian
ENV CPU_MHZ=3800

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
RUN mkdir -p ${INPUT_HOME_DIR}/steamcmd \
    && curl -o /tmp/steamcmd.tar.gz "${STEAMCMD_URL}" \
    && tar -xvzf /tmp/steamcmd.tar.gz -C ${INPUT_HOME_DIR}/steamcmd \
    && rm -rf /tmp/*

# Remove curl and clean-up apt
RUN apt-get remove --purge -y curl && \
        apt-get clean autoclean && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg} /var/{cache,log}

RUN useradd -d ${INPUT_HOME_DIR} -m -s /bin/bash ${INPUT_USER}
RUN mkdir -p ${INPUT_HOME_DIR}/scripts
RUN mkdir -p ${INPUT_HOME_DIR}/Steam/linux32
RUN mkdir -p ${INPUT_HOME_DIR}/Steam/logs
RUN mkdir -p ${INPUT_HOME_DIR}/.steam/sdk32
RUN ln -s ${INPUT_HOME_DIR}/Steam/linux32/steamclient.so ${INPUT_HOME_DIR}/.steam/sdk32/steamclient.so
RUN chown -R ${INPUT_USER}:${INPUT_USER} ${INPUT_HOME_DIR}

ADD download.sh ${INPUT_HOME_DIR}/scripts/download.sh
ADD run.sh ${INPUT_HOME_DIR}/scripts/run.sh
ADD start.sh ${INPUT_HOME_DIR}/scripts/start.sh

WORKDIR ${INPUT_HOME_DIR}
ENTRYPOINT ["/home/services/scripts/run.sh"]
