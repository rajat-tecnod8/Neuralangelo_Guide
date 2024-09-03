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

## Install Neuralangelo Docker Image
```bash
docker pull chenhsuanlin/neuralangelo:23.04-py3
```

Run the container
```bash
docker run -it --gpus all --name neuralangelo_container chenhsuanlin/neuralangelo:23.04-py3
```
