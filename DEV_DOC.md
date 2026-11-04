# DEV_DOC

# Setting up the environment
Prerequisites: Linux (Debian), Docker Engine, Docker Compose
Configuration files: create .env file with .env.example
1. clone repository to host environment: git clone <link> <repo_name>
2. create configuration .env file inside srcs/: cp srcs/.env.example srcs/.env
3. edit .env file if necessary

# Build and launch project (using Makefile & Docker Compose)
The Makefile builds & starts the services by first creating Docker images and then the containers.
## Command               Action
make                     full build & start
make build               rebuild images only

# Managing containers and volumes (useful commands)
## Command	            Action
make / make up          Creates directories, builds missing images, and launches containers.
make down               Stops and removes containers and custom networks without losing data.
make status             Runs docker compose ps to inspect running container states.

# Data storage location/persistance
Data is stored persistently on the host filesystem and mapped into containers using Docker named volumes.
Wordpress volume is mounted into `/var/www/html`
MariaDB volume is mounted into `/var/lib/mysql`

Persistance locations:
x MariaDB Database Data: /home/nrumpfhu/data/mariadb
x WordPress Website Files: /home/nrumpfhu/data/wordpress

Persistence Logic:
The project uses Docker named volumes (`mariadb_data`, `wordpress_data`),
configured so that their data is stored on the host in `/home/nrumpfhu/data/`.
Run `make down` if you want to remove the containers but keep the volumes and data.
