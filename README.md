# DigitalOcean Terraform Voice Automation


## Get DigitalOcean Personal Access Token

### Generate New Personal Access Token ` API > Tokens/Keys `

![alt text](/Screenshots/do-generate-token.png?raw=true "do-token-generate")


### Name Your Access Token

![alt text](/Screenshots/newtoken.png?raw=true "do-token-generate")


### Token Created

**Copy Token (It won't be displayed again)** 

![alt text](/Screenshots/token.png?raw=true "do-token-generate")


## Pull Docker Image

`docker pull harssssshh/dobot`

![alt text](/Screenshots/pull-image.png?raw=true "do-token-generate")


## Run Container 

`docker run -it --device /dev/snd:/dev/snd -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native     -v ~/.config/pulse/cookie:/root/.config/pulse/cookie -v botcredentials:/tmp/ --group-add $(getent group audio | cut -d: -f3) --name dobot  harssssshh/dobot`


![alt text](/Screenshots/cluster-creation.png?raw=true "do-token-generate")

## Enter Token 

![alt text](/Screenshots/enter-token.png?raw=true "do-token-generate")

## Check Cluster Status

![alt text](/Screenshots/do-cluster.png?raw=true "do-token-generate")

## Cluster Created

![alt text](/Screenshots/cluster-created.png?raw=true "do-token-generate")


## Copy kubeconfig Credentials

`sudo cp /var/lib/docker/volumes/botcredentials/_data/config ~/.kube/config`

`kubectl get nodes`

![alt text](/Screenshots/kubectl-nodes.png?raw=true "do-token-generate")

