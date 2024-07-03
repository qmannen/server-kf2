FROM steamcmd/steamcmd:ubuntu-24

ENV ADMIN="admin"
ENV ADMIN_PASSWORD="admin"
ENV START_MAP="kf-bioticslab"
ENV MAX_PLAYERS=6
ENV DIFFICULTY=0

#Options: Survival, Versus, Weekly, Endless
ENV GAMEMODE=Survival 

ADD install.sh /root/install.sh
ADD run.sh /root/run.sh
ADD start.sh /root/start.sh

CMD /root/run.sh