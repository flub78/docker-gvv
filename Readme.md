# docker-flub78/GVV2

defines a docker container running Arch Linux with the LAMP stack installed

## Usage

1. [**Install docker**](https://docs.docker.com/installation/)
1. **Download and start the GVV server instance**  
`docker run --name gvv -p 80:80 -p 443:443 -d flub78/gvv2`
1. **Test the GVV server**  
Point your browser to:  
http://localhost/gvv  
