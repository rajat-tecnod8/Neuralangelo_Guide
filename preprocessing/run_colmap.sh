#!/bin/bash

SEQUENCE="lego"
PATH_TO_VIDEO="Light_scan.mp4"
DOWNSAMPLE_RATE=20
SCENE_TYPE="object"  # {outdoor,indoor,object}

# Define the path
colmap_path="datasets/${SEQUENCE}_ds${DOWNSAMPLE_RATE}"

# Remove any existing dataset folder
sudo rm -rf $colmap_path

# Run the preprocessing script
sudo bash projects/neuralangelo/scripts/preprocess.sh $SEQUENCE $PATH_TO_VIDEO $DOWNSAMPLE_RATE $SCENE_TYPE

# Check the number of images registered
if [ -d "${colmap_path}/images" ]; then
  num_images=$(ls -1 ${colmap_path}/images | wc -l)
  echo "----------------------------------------"
  echo "Number of registered images: ${num_images}"
else
  echo "Images directory not found!"
fi
