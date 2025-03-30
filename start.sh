xhost +local:docker

docker run --rm --name deep-live-cam \
    -it \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/data:/app/pics \
    --gpus all \
    --user 0 \
    --privileged deeplivecam /bin/bash
