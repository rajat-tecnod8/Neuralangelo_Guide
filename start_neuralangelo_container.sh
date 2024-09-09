sudo docker run -it --gpus all --name neuralangelo_container \
    --shm-size=8g \
    --ipc=host \
    --volume /home/rajat-gcp/neuralangelo:/workspace/neuralangelo \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    chenhsuanlin/neuralangelo:23.04-py3
