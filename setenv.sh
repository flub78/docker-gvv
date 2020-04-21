# Set environment for the GVV containers

# Environment must be set during build and while starting docker-compose

export GVV_MYSQL_DIR='/home/frederic/docker/storage/mysql/gvv'
export GVV_HOME='/home/frederic/docker/storage/gvv'

export PORT_PHPMYADMIN='7090'
export PORT_HTTP='90'
export PORT_HTTPS='543'

# Base for the container names
export COMPOSE_PROJECT_NAME='gvv'

# Database configuration
export MYSQL_ROOT_PASSWORD='mysql_password'
export MYSQL_USER_NAME='gvv_user'
export MYSQL_USER_PASSWORD='user_password'

# Domain for the main application
export DOMAIN='flub78.fr'

# Build identification
export SVN_VERSION='trunk/gvv'
# export CONTAINER_VERSION='2285'
export CONTAINER_VERSION='latest'
export REVISION="-r $CONTAINER_VERSION"
