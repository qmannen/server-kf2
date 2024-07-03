FROM steamcmd/steamcmd:ubuntu-24

ENV HOME=kf2
ENV USER=kf2

ENV ADMIN="admin"
ENV ADMIN_PASSWORD="admin"
ENV START_MAP="kf-bioticslab"
ENV MAX_PLAYERS=6
ENV DIFFICULTY=0
ENV ENABLE_WEBADMIN=false

RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/kf2 -m -s /bin/bash kf2

#Options: Survival, Versus, Weekly, Endless
ENV GAMEMODE=Survival 

RUN mkdir -p /home/kf2

ADD install.sh /home/kf2/install.sh
ADD run.sh /home/kf2/run.sh
ADD start.sh /home/kf2/start.sh

WORKDIR /home/kf2

ADD kf2server.ini /tmp/kf2server.ini

USER kf2


ENTRYPOINT [ "/home/kf2/run.sh" ]