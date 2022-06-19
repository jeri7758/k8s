#!/bin/bash
ssh -o StrictHostKeychecking=no jeri@34.93.4.5 \
"sed -i\ 's\tagname\44\g' deploy.yaml && \
sudo cp -av deploy.yaml /var/lib/jenkins/workspace/kub_test/deployment.yaml"