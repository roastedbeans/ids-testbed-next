# MyData System Dockerized

This repository contains a Docker setup to run all components of the MyData system in a unified environment. It includes three main services:

1. **Certification Authority** - Runs on port 3000
2. **Information Provider** - Runs on port 4000
3. **MyData Operator** - Runs on port 4200

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone the repository including all subprojects:

   ```
   git clone <repository-url>
   ```

2. Review the `.env` file and modify any environment variables as needed.

   > ⚠️ **Security Note**: The `.env` file contains sensitive information including database credentials. Do not commit it to version control in a production environment.

## Running the Project

To start all services:

```bash
docker-compose up -d
```

This will build and start all three services in detached mode.

To view logs:

```bash
# View logs for all services
docker-compose logs -f

# View logs for a specific service
docker-compose logs -f certification-authority
docker-compose logs -f information-provider
docker-compose logs -f mydata-operator
```

To stop all services:

```bash
docker-compose down
```

## Service URLs

When all services are running, they will be available at:

- Certification Authority: http://localhost:3000
- Information Provider: http://localhost:4000
- MyData Operator: http://localhost:4200

## Development and Troubleshooting

- If you need to rebuild a service after making changes:

  ```bash
  docker-compose build <service-name>
  docker-compose up -d <service-name>
  ```

- To enter a running container for debugging:

  ```bash
  docker-compose exec <service-name> /bin/sh
  ```

- To view the logs from a running container:
  ```bash
  docker-compose logs -f <service-name>
  ```

## Note on Database Connections

This setup assumes that all services use the same database but with different schemas or connection parameters. Adjust the database connection parameters in the `.env` file according to your specific setup.
