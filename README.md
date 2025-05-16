# Overview
Inception is a System Administration project from School 42 that focuses on Docker containerization. The goal is to set up a small infrastructure of services using Docker Compose.


# Project Description
This project requires creating a multi-container environment where each service runs in its own dedicated container built from Alpine or Debian Linux. The containers must communicate with each other through a Docker network.


# Requirements
Services:

- NGINX: Web server with TLS/SSL
- WordPress: CMS with PHP-FPM
- MariaDB: Database server

Key Components:

- Docker Compose for orchestration
- Custom Dockerfiles for each service
- Persistent volumes for data storage
- Docker network for container communication
- Auto-restart functionality for containers

# Main Features

NGINX as the only entry point via HTTPS (port 443)
Secure MariaDB configuration
WordPress with PHP-FPM
Data persistence through Docker volumes
TLS/SSL encryption
