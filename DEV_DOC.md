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
make re                  full env reset & rebuild

# Managing containers and volumes (useful commands)
## Command	            Action
make / make up          Creates directories, builds missing images, and launches containers.
make down               Stops and removes containers and custom networks without losing data.
make status             Runs docker compose ps to inspect running container states.
make logs               Displays logs from all three services for debugging.
make clean              Stops containers and runs docker system prune -a --force.
make fclean             Full purge: removes containers, networks, images, and deletes stored data.

# Data storage location/persistance
Data is stored persistently on the host filesystem and mapped into containers using Docker named volumes backed by local bind drivers.
Host Storage Locations:
x MariaDB Database Data: /home/nrumpfhu/data/mariadb
x WordPress Website Files: /home/nrumpfhu/data/wordpress

Persistence Logic:
x When make or make prepare runs, host folders are created using mkdir -p.
x In docker-compose.yml, named volumes are mapped directly to these host paths.
x When containers are stopped via make down, files remain untouched inside /home/nrumpfhu/data/.
x Running make fclean will purge the contents of /home/nrumpfhu/data/* and reset the environment for testing a fresh installation.