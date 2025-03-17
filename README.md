# MyData Integrated Authentication System with Intrusion Detection

A comprehensive security research implementation that simulates the MyData ecosystem with advanced intrusion detection capabilities.

## Setup Instructions

### Prerequisites

- Docker and Docker Compose
- Node.js (for local development)
- PostgreSQL (or Supabase account)

### Installation and Configuration

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

### Running Intrusion Detection

The system includes several scripts for different detection methods:

1. Signature-based detection:

   ```bash
   # Inside certification-authority container
   docker-compose exec certification-authority node scripts/detectionSignature.js
   ```

2. Specification-based detection:

   ```bash
   # Inside certification-authority container
   docker-compose exec certification-authority node scripts/detectionSpecification.js
   ```

3. Hybrid detection:

   ```bash
   # Inside certification-authority container
   docker-compose exec certification-authority node scripts/detectionHybrid.js
   ```

4. Analysis dashboard:
   ```bash
   # Inside certification-authority container
   docker-compose exec certification-authority node scripts/analysis.js
   ```

### Development and Troubleshooting

#### Rebuilding Services

```bash
docker-compose build <service-name>
docker-compose up -d <service-name>
```

#### Viewing Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f certification-authority
docker-compose logs -f information-provider
docker-compose logs -f mydata-operator
```

#### Debugging

```bash
# Enter a running container
docker-compose exec <service-name> /bin/sh
```

## Project Overview

This system is a research-focused implementation that simulates the complete MyData ecosystem architecture. It is designed to demonstrate how personal data can be securely managed in a distributed system while providing robust security through multiple intrusion detection methodologies.

The project serves as a practical demonstration of:

1. How the MyData framework operates in a real-world scenario
2. How different intrusion detection methods can be implemented and compared
3. How security datasets can be generated and analyzed for research purposes

## System Architecture

The architecture implements a fully functional MyData ecosystem with three core services:

### 1. Certification Authority (Port 3000)

The Certification Authority serves as the trust anchor for the entire system. It:

- Verifies the identity of users and organizations
- Issues digital certificates for secure communications
- Maintains a registry of authorized participants
- Validates authentication requests
- Monitors for suspicious activities through the intrusion detection system

### 2. Information Provider (Port 4000)

The Information Provider (implemented as "Bond Bank") represents entities that hold personal data. It:

- Securely stores user information
- Implements consent management for data sharing
- Validates data access requests against user permissions
- Logs all data access events for audit purposes
- Applies security controls before releasing data

### 3. MyData Operator (Port 4200)

The MyData Operator (implemented as "Anya Bank") acts as the intermediary that facilitates secure data transmission. It:

- Orchestrates the flow of information between providers and consumers
- Manages user consent records
- Enforces access policies
- Provides a consistent interface for data exchange
- Ensures compliance with MyData principles

These services interact in a carefully designed authentication flow that ensures data is only shared with proper authorization while maintaining comprehensive security logs for analysis.

## Data Flow and Normal Behavior

Under normal operation, the system follows this typical flow:

1. **User Authentication**

   - User initiates login at the MyData Operator
   - Operator redirects to Certification Authority for authentication
   - User provides credentials to Certification Authority
   - Certification Authority validates identity and issues token
   - User is redirected back to Operator with valid token

2. **Consent Management**

   - User reviews and manages data sharing permissions
   - Consent decisions are recorded with timestamps and scope
   - Information Provider is notified of consent changes

3. **Data Request and Fulfillment**
   - MyData Operator requests specific data from Information Provider
   - Request includes valid authorization token and purpose
   - Information Provider validates the request against consent records
   - If authorized, data is securely transmitted to Operator
   - All transactions are logged for audit purposes

## Intrusion Detection System (IDS)

What makes this implementation unique is the comprehensive intrusion detection system that employs multiple detection methodologies:

### Detection Approaches

#### 1. Signature-based Detection

The signature-based detection mechanism:

- Maintains an extensive database of known attack patterns
- Scans all incoming requests for matches against these patterns
- Detects common attacks including SQL injection, XSS, SSRF, XXE, and path traversal
- Provides immediate blocking of recognized attack attempts
- Is highly efficient for known threat vectors

While effective against known attacks, this approach may miss novel or zero-day vulnerabilities that don't match existing signatures.

#### 2. Specification-based Detection

The specification-based detection mechanism:

- Enforces strict schema validation using Zod for all data inputs and outputs
- Verifies that requests conform to expected formats, types, and ranges
- Monitors for anomalies in request patterns and frequencies
- Detects protocol violations and business logic attacks
- Can identify novel attacks that violate defined specifications

This approach excels at detecting attacks that attempt to exploit business logic or use valid-looking but malicious inputs.

#### 3. Hybrid Detection

The hybrid detection combines the strengths of both approaches:

- Uses specification-based detection as a primary filter
- Applies signature-based detection as a secondary verification layer
- Implements a scoring system that considers both detection methods
- Provides more comprehensive coverage than either method alone
- Reduces false positives through correlation of multiple signals

### Rate Limiting and Anomaly Detection

The system includes sophisticated traffic analysis features:

- Tracks request patterns over configurable sliding time windows
- Applies differentiated rate limits based on client identity and endpoint sensitivity
- Detects unusual traffic patterns that might indicate reconnaissance or DDoS attempts
- Implements progressive response measures based on threat severity
- Automatically adjusts baseline expectations based on historical patterns

## Dataset Generation and Analysis

A key research contribution of this project is its comprehensive logging and dataset generation capabilities, specifically designed for security research.

### Log Collection Architecture

The system implements a distributed logging architecture that:

- Captures detailed information at each component
- Standardizes log formats across services
- Ensures chronological consistency with synchronized timestamps
- Preserves context through correlation IDs across service boundaries
- Separates security-relevant events from operational logs

### Dataset Components

The security dataset includes:

1. **Request/Response Data**

   - Complete HTTP request and response payloads
   - Headers and metadata
   - Timestamps and duration
   - Source and destination identifiers

2. **Authentication Events**

   - Login attempts (successful and failed)
   - Token issuance and validation events
   - Session management activities
   - Credential updates

3. **Authorization Decisions**

   - Consent management actions
   - Access control evaluations
   - Policy enforcement events
   - Permission changes

4. **System State Changes**
   - Configuration modifications
   - Service starts and stops
   - Resource utilization metrics
   - Error conditions

### Normal vs. Attack Behavior Profiling

The system carefully distinguishes between normal and attack behaviors:

#### Normal Behavior Characteristics

Normal behavior in the logs shows predictable patterns:

- Requests follow expected sequences (authentication → consent → data access)
- Payloads conform strictly to defined schemas
- Authentication attempts succeed within few tries
- Request rates remain within historical norms for time periods
- Data access patterns align with legitimate business needs
- Session durations fall within typical ranges

The system builds baseline profiles of normal behavior through:

- Statistical analysis of historical patterns
- Time-series modeling of request frequencies
- Clustering of similar user behaviors
- Identification of common workflows

#### Attack Behavior Signatures

Attack behaviors manifest in distinctive ways across the logs:

- Deviation from expected request sequences
- Malformed or boundary-testing inputs
- Multiple failed authentication attempts
- Unusual access patterns or request rates
- Attempts to access unauthorized resources
- Session anomalies or manipulation attempts

The system specifically logs these attack indicators:

- Signature match details (pattern ID, match location, confidence)
- Schema violation specifics (field, expected vs. actual value)
- Authentication anomalies (timing, retry patterns, credential variations)
- Rate limit violations (counts, time windows, affected endpoints)

### Dataset Generation Tools

The project includes several utilities for generating and analyzing security datasets:

1. **Log Processing Pipeline**

   ```
   Raw Logs → Normalization → Enrichment → Feature Extraction → Dataset Generation
   ```

2. **Transformation Tools**

   - Log parsers that convert raw logs to structured CSV
   - Feature extractors that identify security-relevant attributes
   - Contextual enrichment adding environmental metadata
   - Labeling tools for attack classification

3. **Analysis Utilities**
   - Sliding window analysis for traffic pattern detection
   - Visualization tools for behavior profiling
   - Confusion matrix calculation for detection performance
   - Comparative analysis between detection methods

### Performance Metrics

The IDS automatically calculates key performance indicators:

- True Positive Rate: Correctly identified attacks
- False Positive Rate: Normal behavior incorrectly flagged as attacks
- True Negative Rate: Correctly identified normal behavior
- False Negative Rate: Attacks incorrectly classified as normal
- Precision: Proportion of attack alerts that are actual attacks
- Recall: Proportion of actual attacks that are detected
- F1 Score: Harmonic mean of precision and recall
- Detection Time: Time from attack initiation to detection

These metrics are calculated separately for each detection method, enabling comparative analysis of effectiveness.

## Technologies Used

The implementation leverages modern web technologies:

- **Backend**: Next.js with API routes and server-side rendering
- **Database**: PostgreSQL (via Supabase)
- **Authentication**: Custom JWT implementation with role-based access
- **Schema Validation**: Zod for runtime type checking and validation
- **Containerization**: Docker and Docker Compose
- **Logging**: Custom CSV-based logging system with analysis tools
- **Security**: Advanced pattern matching for attack detection

## Security Considerations

- The `.env` file contains sensitive information - never commit it to version control
- For testing purposes, the `.env` variables are on `.env.example` for an easier transfer of project
- For production environments, use secrets management services
- Regularly update the attack signature database for effective detection
- The system is designed for educational purposes and may require additional hardening for production use

## License

[MIT License](LICENSE)
