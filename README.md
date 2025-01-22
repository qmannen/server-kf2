# killingfloor2-server
A containerized Killing Floor 2 server based on the [Debian](https://hub.docker.com/u/debian) image

# commands for starting,restarting,ssh into, and stopping container
Start kf2 in daemon mode
$ docker-compose up --build --force-recreate -d

Stop running docker conatiner. If you are in the folder where the running docker is located you dont need a container ID after stop
$ docker-compose stop

Restart running docker container
$ docker-compose restart

See process/processes ID
$ docker ps

Se logs
$ docker logs 786d39263358 # (ID from docker ps)

Go into docker container / ssh into docker container
$ docker exec -it 786d39263358 bash
