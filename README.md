# MyData Integrated Authentication System with Intrusion Detection

This project implements a toy program that mimics MyData integrated authentication ecosystem, featuring a complete simulation of certification authorities, information providers, and MyData business operators (information receivers). The system also incorporates advanced intrusion detection capabilities with multiple detection approaches for enhanced security.

## Project Overview

This system simulates the MyData ecosystem architecture with the following core components:

1. **Certification Authority** - Responsible for verifying identities and issuing certificates
2. **Information Provider** - Provides user data with proper authorization
3. **MyData Operator** - Facilitates data transmission between providers and services

What makes this implementation unique is the integration of multiple intrusion detection methodologies:

- **Signature-based Detection**: Identifies known attack patterns in requests and responses
- **Specification-based Detection**: Verifies requests against predefined schemas and rules
- **Hybrid Detection**: Combines both approaches, using specification verification as primary and signature matching as secondary detection

## System Architecture

The system runs in a fully dockerized environment with three main services:

- **Certification Authority**: Runs on port 3000
- **Information Provider**: Runs on port 4000
- **MyData Operator**: Runs on port 4200

These services interact in a secure authentication flow that validates user requests, processes consent, and facilitates data sharing according to the MyData principles.

## Intrusion Detection System (IDS)

### Detection Approaches

1. **Signature-based Detection**

   - Uses predefined patterns to identify known attacks
   - Maintains an extensive database of attack signatures for SQL injection, XSS, SSRF, XXE, path traversal, and more
   - Highly effective against known threats but may miss zero-day attacks

2. **Specification-based Detection**

   - Enforces strict validation against predefined schemas using Zod
   - Monitors for request/response anomalies based on expected formats
   - Can detect novel attacks that violate defined specifications
   - Particularly effective against protocol violations and business logic attacks

3. **Hybrid Detection**
   - Combines both approaches in a layered security model
   - Uses specification-based detection as primary filter
   - Applies signature-based detection as secondary verification
   - Provides better coverage than either method alone

### Rate Limiting and Anomaly Detection

The system includes a sophisticated rate limiting mechanism that:

- Tracks request patterns over sliding windows
- Applies different limits per client and endpoint
- Detects traffic anomalies and potential DDoS attempts

## Dataset Generation and Analysis

### Log Collection

The system collects comprehensive logs across all components:

- Request and response payloads
- Headers and metadata
- Authentication attempts
- Authorization decisions

### Dataset Generation Tools

The project includes several tools for generating and analyzing security datasets:

- Log parsing utilities that convert raw logs to formatted CSV
- Sliding window analysis for traffic pattern detection
- Confusion matrix calculation for performance evaluation

### Performance Metrics

The IDS monitors and calculates key performance indicators:

- True Positive/Negative and False Positive/Negative rates
- Precision, recall, and F1 scores for each detection method
- Comparative analysis between detection approaches

## Technologies Used

- **Backend**: Next.js with API routes and server-side rendering
- **Database**: PostgreSQL (via Supabase)
- **Authentication**: Custom JWT implementation with role-based access
- **Schema Validation**: Zod for runtime type checking and validation
- **Containerization**: Docker and Docker Compose
- **Logging**: Custom CSV-based logging system with analysis tools
- **Security**: Advanced pattern matching for attack detection

## Prerequisites

- Docker and Docker Compose
- Node.js (for local development)
- PostgreSQL (or Supabase account)

## Setup Instructions

1. Clone the repository including all subprojects:

   ```bash
   git clone <repository-url>
   ```

2. Create an `.env` file based on `.env.example`:

   ```bash
   cp .env.example .env
   ```

3. Configure the environment variables:

   ```
   # Shared variables
   JWT_SECRET=your-jwt-secret

   # Certification Authority variables
   CA_CODE=certauth00
   CA_PRIVATE_KEY=your-ca-private-key
   CA_PUBLIC_KEY=your-ca-public-key

   # Database variables
   DATABASE_URL=your-database-connection-string
   DIRECT_URL=your-direct-database-connection-string

   # Bond Bank variables (for information provider)
   BOND_BANK_API=http://localhost:4200
   BOND_ORG_CODE=your-bond-org-code
   BOND_ORG_SERIAL_CODE=your-bond-serial-code

   # Anya Bank variables (for information receiver)
   ANYA_BANK_API=http://localhost:4000
   ANYA_ORG_CODE=your-anya-org-code
   ANYA_ORG_SERIAL_CODE=your-anya-serial-code
   ```

4. Build and start the containers:

   ```bash
   docker-compose up -d
   ```

5. Access the services:
   - Certification Authority: http://localhost:3000
   - Information Provider: http://localhost:4000
   - MyData Operator: http://localhost:4200

## Development and Troubleshooting

### Rebuilding Services

```bash
docker-compose build <service-name>
docker-compose up -d <service-name>
```

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f certification-authority
docker-compose logs -f information-provider
docker-compose logs -f mydata-operator
```

### Debugging

```bash
# Enter a running container
docker-compose exec <service-name> /bin/sh
```

## Running Intrusion Detection

The system includes several scripts for intrusion detection:

1. Signature-based detection:

   ```bash
   # Inside certification-authority container
   node scripts/detectionSignature.js
   ```

2. Specification-based detection:

   ```bash
   # Inside certification-authority container
   node scripts/detectionSpecification.js
   ```

3. Hybrid detection:

   ```bash
   # Inside certification-authority container
   node scripts/detectionHybrid.js
   ```

4. Analysis dashboard:
   ```bash
   # Inside certification-authority container
   node scripts/analysis.js
   ```

## Security Considerations

- The `.env` file contains sensitive information - never commit it to version control
- For production environments, use secrets management services
- Regularly update the attack signature database for effective detection
- The system is designed for educational purposes and may require additional hardening for production use

## License

[MIT License](LICENSE)
