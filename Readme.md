# flub78/docker-gvv

defines a docker container with a live GVV application.

## Usage

1. [**Install docker**](https://docs.docker.com/installation/)
1. **Download and start the GVV server instance**  
`docker run -d -p 10080:80 -p 10022:22 --name=gvv flub78/docker-gvv`
`docker run -d -p 10080:80 -p 10022:22 -v $HOME/.ssh/id_rsa.pub/:/root/.ssh/authorized_keys --name=gvv flub78/docker-gvv`

1. **Test the GVV server**  
Point your browser to:  docker 
http://localhost:10080/gvv/install/

1. access with ssh
ssh root@localhost -p 10022



