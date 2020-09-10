# DigitalOcean Terraform Voice Automation


## Get DigitalOcean Personal Access Token


## Pull Docker Image

`docker pull harssssshh/dobot`

## Run Container 

`docker run -it --device /dev/snd:/dev/snd -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native     -v ~/.config/pulse/cookie:/root/.config/pulse/cookie -v botcredentials:/tmp/ --group-add $(getent group audio | cut -d: -f3) --name dobot  harssssshh/dobot`


`
