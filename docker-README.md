# MyData Docker Setup

This repository contains a Docker-based setup for running the MyData architecture components:

1. Certification Authority (certification-authority-next)
2. Information Provider (information-provider-next)
3. MyData Operator (mydata-operator-next)

## Architecture Overview

The setup consists of the following services:

- **Certification Authority**: Runs on port 3000
- **Information Provider**: Runs on port 4000
- **MyData Operator**: Runs on port 4200
- **PostgreSQL**: Shared database for all services
- **Redis**: Used for caching and session management

All services are configured to communicate with each other via an internal Docker network.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git to clone the repository

## Getting Started

1. Clone the repository:

```bash
git clone <repository-url>
cd mydata
```

2. Build and start the services:

```bash
docker-compose up -d
```

This command will:

- Build Docker images for all three services
- Create and start all containers
- Set up the network and volumes

3. Check if all services are running:

```bash
docker-compose ps
```

## Accessing Services

- Certification Authority: http://localhost:3000
- Information Provider: http://localhost:4000
- MyData Operator: http://localhost:4200

## Environment Variables

All environment variables are configured in the `docker-compose.yml` file. No additional `.env` file is needed.

## Database Persistence

PostgreSQL data is persisted in a Docker volume named `postgres-data`. This ensures that your data is preserved between container restarts.

## Stopping Services

To stop all services:

```bash
docker-compose down
```

To stop and remove all containers, networks, and volumes:

```bash
docker-compose down -v
```

## Troubleshooting

1. If you encounter issues with database connections, ensure the PostgreSQL container is running and healthy:

```bash
docker-compose logs postgres
```

2. For issues with service communication, check the Docker network:

```bash
docker network inspect mydata-network
```

3. To check logs for a specific service:

```bash
docker-compose logs <service-name>
```

Example: `docker-compose logs certification-authority`

## Development

For development purposes, you can modify the Dockerfiles or docker-compose.yml file as needed. After making changes, rebuild the affected services:

```bash
docker-compose up -d --build <service-name>
```
