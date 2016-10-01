# flub78/docker-gvv

defines a docker container running Arch Linux with the LAMP stack installed

## Usage

1. [**Install docker**](https://docs.docker.com/installation/)
1. **Download and start the GVV server instance**  
`docker run --name gvv -p10080:80 flub78/gvv2 -d`
`docker run -ti --name gvv -p10080:80 flub78/gvv2 /bin/bash`

1. **Test the GVV server**  
Point your browser to:  
http://localhost:10080/gvv/install/



