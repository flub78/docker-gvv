# Set environment for the GVV containers

# Environment must be set during build and while starting docker-compose

# Base for the container names
export COMPOSE_PROJECT_NAME='gvv'

# Database configuration
export MYSQL_ROOT_PASSWORD='mysql_password'
export MYSQL_USER_NAME='gvv_user'
export MYSQL_USER_PASSWORD= 'user_password'

# Domain for the main application
export DOMAIN='flub78.fr'

# Build identification
export SVN_VERSION='trunk/gvv'
export REVISION="-r 2285"
