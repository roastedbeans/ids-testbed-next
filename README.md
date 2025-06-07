# MyData Testbed Docker Setup

A simplified Docker setup for the MyData testbed with three Next.js applications.

## Services

- **Certification Authority** - Port 3000
- **Information Provider** - Port 4000
- **MyData Operator** - Port 4200

## Quick Start

1. Copy the environment file:

   ```bash
   cp env.example .env
   ```

2. Update the database URLs in `.env` with your database credentials:

   ```
   DATABASE_URL="postgresql://username:password@hostname:port/database?schema=public"
   DIRECT_URL="postgresql://username:password@hostname:port/database?schema=public"
   ```

3. Build and start the services:

   ```bash
   docker-compose up --build
   ```

4. Access the services:
   - Certification Authority: http://localhost:3000
   - Information Provider: http://localhost:4000
   - MyData Operator: http://localhost:4200

## Configuration

All application configuration is now embedded in the individual Dockerfiles for simplicity. Only the database URLs need to be configured via environment variables.

## Database Setup

The applications use Prisma with PostgreSQL. Make sure to run database migrations for each service after the first setup:

```bash
# For each service, run migrations
docker-compose exec certification-authority npx prisma migrate deploy
docker-compose exec information-provider npx prisma migrate deploy
docker-compose exec mydata-operator npx prisma migrate deploy
```
