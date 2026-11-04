*This project has been created as part of the 42 curriculum by nrumpfhu.*

# Inception 42

## Description

Inception is a System Administration project in the 42 curriculum designed to deepen understanding of virtualization, containerization, and service isolation using Docker. The goal is to build a multi-container web infrastructure from scratch using Docker Compose.

Each service runs in its own isolated container built from Dockerfiles using Debian or Alpine as a base image:
- **NGINX:** Serves as the sole entry point to the infrastructure, configured with TLS v1.2 / TLS v1.3 on port 443.
- **WordPress:** Powered by PHP-FPM to handle dynamic web traffic without a standalone web server installed in the container.
- **MariaDB:** Database service providing backend persistent storage for WordPress.

---

### 1. Virtual Machines vs Docker

Virtual Machines:
A Virtual Machine (VM) emulates a full physical computer, complete with its own independent guest operating system. Because every VM virtualizes hardware, it requires dedicated memory and CPU resources, making it heavy and slow to boot. They are typically used when total OS isolation or running a different OS kernel from the host is strictly required.

Docker:
For understanding Docker, understanding containers is key. Containers don't simulate an entire computer, but create an environment specifically for one job to work. Therefore, Containers have the lightest possible version of an OS/software. Docker is a way to build and run those containers. Compared to VMs, using Docker results in fast start times, minimal resource overhead, and efficient execution.


Inception Choice
Docker images were virtualized and created on a virtual machine. NGINX, WordPress and MariaDB are individual Docker containers which provides secure process isolation without wasting host CPU and memory on multiple guest operating systems.

---

### 2. Secrets vs Environment Variables

#### Secrets
Docker Secrets provide a mechanism for managing sensitive data (like database passwords or API keys) by storing the information securely and mounting it strictly in memory inside authorized containers. Secrets are never exposed in plain text in container metadata, process trees, or build logs, preventing credential leaks.

#### Environment Variables
Environment variables pass configuration parameters directly to containers as key-value pairs via `.env` files or compose definitions. While straightforward to implement, they are stored in plain text and can be inspected via commands like `docker inspect`. They are best suited for non-sensitive operational settings like domain names, database names, or user accounts.

#### Inception Choice
Because of easy usage, environment variables are chosen. srcs/.env is not pushed to the repo, therefore no sensitive information is leaked. .env should be added before startup.

---

### 3. Docker Network vs Host Network

Docker Network (Custom Bridge)
A custom bridge network creates an isolated virtual communication layer, meaning the containers can communicate privately and shielded from the outside world unless they are exposed to the host on specific ports.

Host Network
Host networking removes the network isolation between the container and the Docker host. The container shares the host's IP address and network stack directly, meaning binding to a port inside the container immediately binds to that port on the physical host machine.

Inception Choice
A Docker network was implemented to strictly control network exposure. MariaDB (port 3306) and WordPress (port 9000) remain hidden inside the private bridge, only NGINX is accessible from the outside on port 443.

---

### 4. Docker Volumes vs Bind Mounts

Docker Volumes
Docker volumes are named storage entities fully managed by Docker inside `/var/lib/docker/volumes/`. They are decoupled from the host directory structure, making them highly portable, safe to manage via the Docker CLI, and the preferred choice for persistent production data.

Bind Mounts
Bind mounts link a container directory directly to a specific, absolute path on the host system. They rely heavily on the host's exact directory layout and file permissions, which makes them less portable.

Inception Choice
Named docker volumes were used as required by the subject.

---

## Instructions

### Prerequisites
- Operating System: Linux
- Docker Engine & Docker Compose

### Setup and Execution

1. Clone the repository and change directory:
   ```bash
   git clone https://github.com/nir1300/inception.git inception
   cd inception
2. .env file in srcs/ folder
3. Map domain name in hosts /etc/hosts file:
   127.0.0.1 nrumpfhu.42.fr
3. use Makefile to build and run the containers. available make commands:
    `make` builds the image and starts all containers
    `make build` only builds the images
    `make up` starts the containers in the background
    `make stop` stops the containers
    `make down` stops and removes the containers
    `make fclean` stops the containers and deletes all data in /home/nrumpfhu/data
    `make re` wipes the data, then rebuilds and restarts everything
 4. open web broswer and see WordPress site:
   https://nrumpfhu.42.fr
5. accept SSH certificate (because it is self-signed, a warning will show - that's  normal)

## Resources
### Documentation
x Docker documentation: https://docs.docker.com/
x Docker compose documentation: https://docs.docker.com/compose/
x NGINX documentation: https://nginx.org/en/docs/
x Wordpress documention: https://wordpress.org/documentation/
x https://make.wordpress.org/cli/handbook/
x MariaDB installation: https://mariadb.com/docs?q=library/transactions
x https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/configuring-mariadb/configuring-mariadb-with-option-files
x Openssl documentation: https://docs.openssl.org/master/man1/openssl-req/
x https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6
x https://smithtalkstech.com/2018/04/25/creating-a-self-signed-ssl-certificate-for-local-docker-development/
x NGINX documention: https://nginx.org/en/docs/http/configuring_https_servers.html
x Commands for testing: https://github.com/waltergcc/42-inception#114-test-the-mariadb-container

### AI Usage
AI was used for the following things:
x Debugging: help debug some build errors when running Docker compose and to figure out syntax problems in Dockerfile.
x Architectural Clarification: Verifying technical differences between Docker network drivers, bind mounts, and DNS routing mechanisms.
x Documentation: help writing and formatting the Markdown files