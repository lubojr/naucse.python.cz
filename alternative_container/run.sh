#/bin/bash

cd "$(dirname "$0")"
IMAGE="naucse-python-alt"
NAME="naucse-server"
SOURCE=$(cd "$PWD/.." ; pwd)

if [ -n "`docker ps -q -f "name=$NAME"`" ]
then
    echo "Container ${NAME} is already running."
elif [ -n "`docker ps -a -q -f "name=$NAME"`" ]
then
    echo "Staring existing container ${NAME}  ... "
    docker start "$NAME" && \
    docker attach "$NAME"
else
    echo "Staring new container ${NAME}  ... "
    docker run -ti \
        --name "$NAME" \
        --publish 127.0.0.1:8003:8003 \
        --volume "$SOURCE:/naucse" \
        "$IMAGE"
fi
