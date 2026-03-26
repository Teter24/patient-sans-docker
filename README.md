# Docker Setup & Installation Guide

This project is containerized using Docker to ensure easy deployment and consistency across environments. Below are the steps to set up, run, and populate the database for the application. For context, this was a small project I had to do for class about a year ago, which is why the database table names aren't necessarily well-chosen. The project focused on adding patients and then adding incidents to them.

## Prerequisites

- **[Docker](https://www.docker.com/get-started)**: Ensure Docker is installed and running on your machine.
- **[Docker Compose](https://docs.docker.com/compose/install/)**: Required to manage the multi-container application.

## Setup Instructions

Open the `.env` file and update the database configuration to match the settings in `docker-compose.yml`. Specifically, modify the following variables:

```ini
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=patient
DB_USERNAME=patients_user
DB_PASSWORD=patients_pass
```

> **Note:** The `DB_HOST` must be set to `mysql` (the service name defined in `docker-compose.yml`), not `127.0.0.1` or `localhost`.

### 3. Build and Start Containers
Build the Docker images (if necessary) and start the containers in detached mode:
```bash
docker-compose up -d --build
```

### 4. Install Dependencies
Install the required PHP dependencies using Composer within the container:
```bash
docker-compose exec app composer install
```

### 5. Generate Application Key
Generate the Laravel application key:
```bash
docker-compose exec app php artisan key:generate
```

### 6. Set Permissions
Ensure the necessary directories are writable by the application:
```bash
docker-compose exec app chmod -R 777 storage bootstrap/cache
```

## Database Population

To populate the database with the initial schema and seed data, execute the provided SQL script `script-sql-docker.sql`.

Run the following command from your terminal (in the project root):

```bash
docker-compose exec -T mysql mysql -u root -proot patient < script-sql-docker.sql
```

This command connects to the `mysql` container and imports the SQL commands from the file into the `patient` database.

## Accessing the Application

- **Web Application**: Access the application at [http://localhost:8000](http://localhost:8000).
    - You will be redirected to the list of patients at `/patients` (route: `patients.index`).

## Docker Architecture

The Docker setup meets the following criteria:

- **Application Container**: Runs the source code using a custom PHP-FPM image built via `Dockerfile`.
- **Database**:
    - Accessible only within the Docker network (no external port mapping for security).
    - Persistent storage using a Docker volume (`mysql_data`) to retain data across restarts.
- **HTTP Server**: An Nginx container acts as the web server and is the only entry point exposed to the host machine (port 8000).

## Source Code Modifications for Docker

To fully support the Docker environment, the following changes were made:

1.  **Dockerfile Creation**: A custom `Dockerfile` was created to package the application with PHP 8.4-FPM and necessary extensions (`pdo_mysql`, `bcmath`, `gd`, etc.).
2.  **Database Configuration**: The application is configured via `.env` to connect to the internal `mysql` service name, ensuring seamless communication within the Docker network.The database was originally in `SQLite`, and I switched it to `mysql`.
3.  **Routing**: The default route `/` has been configured to serve the relevant application content (`patients.index`).

