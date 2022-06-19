#!/bin/bash
ssh -o StrictHostKeychecking=no jeri@34.93.4.5 \
'sudo cp -av /var/lib/jenkins/workspace/kub_test . &&
COMMIT=$(git rev-parse --verify HEAD) && \
sudo docker image build -t jerijs/kub_project . \
--build-arg "app_name=kub_project" \
-t "jerijs/kub_project:latest" \
-t "jerijs/kub_project:${commit}"'
