# Neuralangelo_Guide

## Install NVIDIA drivers
Install drivers
```bash
sudo apt-get update
sudo apt install nvidia-utils-535
sudo apt-get install nvidia-driver-535
```
Reboot the system
```bash
sudo reboot
```
Check if drivers installed properly
```bash
nvidia-smi
```


## Install Docker
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#Test run
sudo docker run hello-world
```

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

## Install Neuralangelo Docker Image
```bash
docker pull chenhsuanlin/neuralangelo:23.04-py3
```

Run the container
```bash
sudo docker run -it --gpus all --name neuralangelo_container \
    --shm-size=8g \
    --ipc=host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    chenhsuanlin/neuralangelo:23.04-py3

```

## Train and run the model
```bash
pip install -r requirements.txt
```

```bash
torchrun --nproc_per_node=1 train.py \
    --logdir=logs/test_exp/lego \
    --show_pbar \
    --config=projects/neuralangelo/configs/custom/lego.yaml \
    --data.readjust.scale=0.5 \
    --max_iter=20000 \
    --validation_iter=99999999 \
    --model.object.sdf.encoding.coarse2fine.step=200 \
    --model.object.sdf.encoding.hashgrid.dict_size=19 \
    --optim.sched.warm_up_end=200 \
    --optim.sched.two_steps=[12000,16000]
```

```bash
GROUP="test_exp"
NAME="lego"
mesh_fname="logs/${GROUP}/${NAME}/mesh.ply"

torchrun --nproc_per_node=1 projects/neuralangelo/scripts/extract_mesh.py \
    --config="logs/${GROUP}/${NAME}/config.yaml" \
    --checkpoint="logs/${GROUP}/${NAME}/epoch_00400_iteration_000020000_checkpoint.pt" \
    --output_file="${mesh_fname}" \
    --resolution=300 --block_res=128 \
    --textured
```
