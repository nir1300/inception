# USER_DOC

# Provided Services
1. **NGINX (Web Gateway):** Serves as the primary HTTPS entry point on port 443. It handles SSL/TLS security and forwards dynamic requests to WordPress.
2. **WordPress (CMS):** A content management system powered by PHP-FPM (runs internally on port 9000).
3. **MariaDB (Database):** A database storing WordPress users, posts, and site settings (runs internally on port 3306).

# Starting/Stopping the project
run following commands from the root directory:
to start program: make 
to stop program: make down

# Accessing the website & admin panel
Before access is possible, add the following line to /etc/hosts (requires sudo access):
127.0.0.1 nrumpfhu.42.fr
access website as user via: https://nrumpfhu.42.fr or localhost
access website admin panel via: https://nrumpfhu.42.fr/wp-admin
(browser will show security warning, click "Advanced" and accept self-signed SSL certificate)

# Locating and Managing Credentials
Non-sensitive settings are storded in srcs/.env. This includes:
DOMAIN_NAME: Set to <login>.42.fr
MYSQL_DATABASE: Name of the WordPress database.
MYSQL_USER: Non-root database username.
WP_ADMIN_USER: Admin account username.
WP_USER: Regular author username.

Sensitive information (e.g. passwords) are stored as text files inside srcs/secrets and treated as Docker Secrets. To change or update password, edit text files in srcs/secrets/ and restart the stack using make re.

# Check service status
check active containers: make status (or docker ps -a)
check logs: make logs
