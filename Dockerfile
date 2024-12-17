FROM steamcmd/steamcmd:debian

ENV ADMIN="admin"
ENV ADMIN_PASSWORD="admin"
ENV START_MAP="kf-bioticslab"
ENV MAX_PLAYERS=6
ENV DIFFICULTY=0
ENV ENABLE_WEBADMIN=true
#Options: Survival, Versus, Weekly, Endless
ENV GAMEMODE=Survival 

RUN dpkg --add-architecture i386 \
 && apt update -y \
 && apt upgrade -y  \
 && apt install -y procps \
 && apt install -y --no-install-recommends \
	curl \
	nano \
	libc6:i386 \
	libstdc++6:i386 \
	lib32z1 \
	libcurl3-gnutls:i386 \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/kf2 -m -s /bin/bash kf2
RUN mkdir -p /home/kf2

#steam port
EXPOSE 20560/udp
#game port
EXPOSE 7777/udp
#web admin port
EXPOSE 8080/tcp
#query port - master server coms, to show up in server browser
EXPOSE 27015/udp

ADD install.sh /home/kf2/install.sh
ADD run.sh /home/kf2/run.sh
ADD start.sh /home/kf2/start.sh

WORKDIR /home/kf2

ENTRYPOINT ["/home/kf2/run.sh" ]
