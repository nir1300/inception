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
Docker relies on OS-level virtualization to run applications in lightweight, isolated containers that share the host system's kernel. Rather than booting an entire OS, containers bundle only the application and its immediate dependencies. This results in fast start times, minimal resource overhead, and efficient execution.

Inception Choice
Docker images were virtualized and created on a virtual machine. NGINX, WordPress and MariaDB are individual Docker containers which provides secure process isolation without wasting host CPU and memory on multiple guest operating systems.

---

### 2. Secrets vs Environment Variables

#### Secrets
Docker Secrets provide a mechanism for managing sensitive data (like database passwords or API keys) by storing the information securely and mounting it strictly in memory (`/run/secrets/`) inside authorized containers. Secrets are never exposed in plain text in container metadata, process trees, or build logs, preventing credential leaks.

#### Environment Variables
Environment variables pass configuration parameters directly to containers as key-value pairs via `.env` files or compose definitions. While straightforward to implement, they are stored in plain text and can be inspected via commands like `docker inspect`. They are best suited for non-sensitive operational settings like domain names, database names, or user accounts.

#### Inception Choice
**A hybrid approach using both Docker Secrets and Environment Variables.** To comply with strict security requirements, all confidential credentials (such as MariaDB root/user passwords and WordPress admin/user passwords) are managed using **Docker Secrets** mounted at `/run/secrets/`. Non-sensitive configuration parameters (such as `DOMAIN_NAME`, `MYSQL_DATABASE`, and usernames) are passed via a `.env` file as **Environment Variables**.

---

### 3. Docker Network vs Host Network

Docker Network (Custom Bridge)
A custom bridge network creates an isolated virtual communication layer managed entirely by Docker. Containers on the network can communicate with each other using service names as domain names via Docker's internal DNS. Services are shielded from the outside world unless specific ports are explicitly mapped to the host interface.

Host Network
Host networking removes the network isolation between the container and the Docker host. The container shares the host's IP address and network stack directly, meaning binding to a port inside the container immediately binds to that port on the physical host machine.

Inception Choice
A **custom Docker bridge network (`inception`)** was implemented to strictly control network exposure. MariaDB (port 3306) and WordPress (port 9000) remain hidden inside the private bridge, leaving NGINX on port 443 as the sole public gateway.

---

### 4. Docker Volumes vs Bind Mounts

Docker Volumes
Docker volumes are named storage entities fully managed by Docker inside `/var/lib/docker/volumes/`. They are decoupled from the host directory structure, making them highly portable, safe to manage via the Docker CLI, and the preferred choice for persistent production data.

Bind Mounts
Bind mounts link a container directory directly to a specific, absolute path on the host system. They rely heavily on the host's exact directory layout and file permissions, which makes them less portable, but useful when sharing live files (like source code during development) directly with the host.

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
   git clone https://github.com/nir1300/inception.git <repo_name>
   cd inception
2. Map domain name in hosts /etc/hosts file:
   127.0.0.1 nrumpfhu.42.fr
3. use Makefile to set up directories and launch containers:
   make
4. open web broswer and see WordPress site:
   https://nrumpfhu.42.fr
5. accept SSH certificate

## Resources
### Documentation
https://docs.docker.com/
https://docs.docker.com/compose/
https://nginx.org/en/docs/
https://make.wordpress.org/cli/handbook/
https://mariadb.com/docs?q=library/transactions
https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/configuring-mariadb/configuring-mariadb-with-option-files
https://github.com/waltergcc/42-inception#114-test-the-mariadb-container
https://docs.openssl.org/master/man1/openssl-req/
https://nginx.org/en/docs/http/configuring_https_servers.html
https://smithtalkstech.com/2018/04/25/creating-a-self-signed-ssl-certificate-for-local-docker-development/
https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6
https://docs.docker.com/reference/cli/docker/secret/create/

### AI Usage
Debugging build errors: Diagnosing path mapping issues in Docker Compose and syntax problems in Dockerfile build steps.
Architectural Clarification: Verifying technical differences between Docker network drivers, bind mounts, and DNS routing mechanisms.
Documentation: Assisting in structuring and formatting this README.md file according to project requirements.