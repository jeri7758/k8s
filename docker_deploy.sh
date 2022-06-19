#!/bin/bash
ssh -o StrictHostKeychecking=no jeri@${SERVER_IP} && \
COMMIT=$(git rev-pasrse --verify HEAD) && \
sudo docker image build -t jerijs/kub_project . \
--build-arg "app_name=kub_project"
-t "jerijs/kub_project:latest"
-t "jerijs/kub_project:${commit}"
