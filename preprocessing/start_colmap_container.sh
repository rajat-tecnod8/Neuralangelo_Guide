sudo docker run -it --gpus all --name colmap_container \
    --shm-size=8g \
    --ipc=host \
    --volume /home/rajat-gcp/neuralangelo:/workspace/neuralangelo \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    chenhsuanlin/colmap:3.8
