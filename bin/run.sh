docker run -d -p 10080:80 -p 10022:22 --name=gvv flub78/gvv docker run -d -p 10080:80 -p 10022:22 -v $HOME/.ssh/id_rsa.pub/:/root/.ssh/authorized_keys --name=gvv flub78/gvv
