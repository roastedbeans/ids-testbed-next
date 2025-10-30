# MyData API Intrusion Detection System

## 🌟 Overview

A **MyData API Security Research Testbed** designed for generating comprehensive datasets for intrusion detection system development. This testbed simulates real-world MyData banking API environments and produces security event data for research into specification-based and signature-based intrusion detection algorithms. The system consists of three integrated Next.js applications working together to simulate authentic API traffic patterns and security events.

## 🏗️ System Architecture

### Core Components

| Component                      | Port | Role                                    | Dataset Generation Features                                               |
| ------------------------------ | ---- | --------------------------------------- | ------------------------------------------------------------------------- |
| **🔐 Certification Authority** | 3000 | Central authentication & dataset hub    | Multi-algorithm detection logs, Security event datasets, OAuth simulation |
| **🏦 Information Provider**    | 4000 | Bank API simulation for data generation | Attack pattern datasets, API traffic logs, Simulation data                |
| **🏛️ MyData Operator**         | 4200 | Enhanced simulation + local detection   | Dual-layer detection datasets, Local threat logs, Response data           |

### Testbed Architecture

```
┌─────────────────────────────────────────────────────────────┐
│              MyData API Research Testbed                    │
├─────────────────────────────────────────────────────────────┤
│  🔐 Certification Authority (Port 3000)                    │
│  ├── Dataset Generation Engine (Signature, Specification,  │
│  │   Hybrid, Rate Limiting Detection Logs)                │
│  ├── Security Event Analytics Dashboard                    │
│  ├── OAuth 2.0 Simulation                                 │
│  └── Centralized Dataset Collection                       │
├─────────────────────────────────────────────────────────────┤
│  🏦 Information Provider (Port 4000)                       │
│  ├── Simulated Bank Account APIs                          │
│  ├── Attack Pattern Generation                            │
│  └── Traffic Simulation & Logging                         │
├─────────────────────────────────────────────────────────────┤
│  🏛️ MyData Operator (Port 4200)                           │
│  ├── Enhanced API Traffic Simulation                      │
│  ├── Local Detection Algorithm Testing                    │
│  ├── Dual-Layer Dataset Generation                        │
│  └── Response Pattern Recording                           │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Option 1: CLI Scripts (Recommended for Development)

#### macOS

```bash
# Install dependencies and launch all services
chmod +x run.sh
./run.sh
```

#### Ubuntu/Linux

```bash
# Install dependencies and launch all services
chmod +x run-ubuntu.sh
./run-ubuntu.sh
```

The CLI scripts will:

- Install npm dependencies for all three services
- Launch each service in separate terminal windows
- Certification Authority: http://localhost:3000
- Information Provider: http://localhost:4000
- MyData Operator: http://localhost:4200

### Option 2: Docker Compose (Production-Ready)

#### 1. Environment Setup

```bash
# Copy environment configuration
cp env.example .env

# Configure database URLs in .env
DATABASE_URL="postgresql://username:password@hostname:port/database?schema=public"
DIRECT_URL="postgresql://username:password@hostname:port/database?schema=public"
```

#### 2. Build and Deploy

```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d --build

# View logs
docker-compose logs -f
```

#### 3. Database Migration

```bash
# Run migrations for all services
docker-compose exec certification-authority npx prisma migrate deploy
docker-compose exec information-provider npx prisma migrate deploy
docker-compose exec mydata-operator npx prisma migrate deploy
```

### Option 3: Manual Development Setup

```bash
# 1. Install dependencies for all services
cd certification-authority-next && npm install && cd ..
cd information-provider-next && npm install && cd ..
cd mydata-operator-next && npm install && cd ..

# 2. Set up databases (run in each service directory)
npx prisma migrate dev
npx prisma generate

# 3. Start services in separate terminals
# Terminal 1
cd certification-authority-next && npm run dev

# Terminal 2
cd information-provider-next && npm run dev

# Terminal 3
cd mydata-operator-next && npm run dev
```

## 📊 Dataset Generation Features

### 🔐 Certification Authority (Central Dataset Hub)

**Multi-Algorithm Dataset Generation:**

- **Signature-Based Detection Logs** - 50+ attack patterns with detection results (SQL injection, XSS, XXE, etc.)
- **Specification-Based Detection Data** - API schema validation events and anomalies
- **Hybrid Detection Datasets** - Combined detection approach with performance metrics
- **Rate Limiting Event Data** - Client behavior patterns and rate limit violations

**Analytics Dashboard:**

```bash
# Access dataset analytics and collection monitoring
http://localhost:3000/security-dashboard
```

**Dataset Generation Commands:**

```bash
cd certification-authority-next

# Generate detection datasets
npm run signature      # Signature-based detection dataset
npm run specification  # Specification-based detection dataset
npm run hybrid         # Hybrid detection dataset (recommended)
npm run ratelimit      # Rate limiting behavior dataset
npm run analysis       # Comprehensive dataset analysis
```

### 🏦 Information Provider (Simulated Bank APIs)

**Simulated Banking APIs:**

- `POST /api/v2/bank/accounts/deposit/basic` - Basic account information simulation
- `POST /api/v2/bank/accounts/deposit/detail` - Detailed account data simulation
- `POST /api/oauth/2.0/token` - Bank-to-bank authentication simulation

**Traffic & Attack Simulation:**

```bash
cd information-provider-next

# Normal traffic simulation for baseline datasets
npm run simulate        # Comprehensive MyData flow simulation
npm run simulateNormal  # Normal operation pattern generation

# Attack pattern generation for intrusion datasets
npm run attack          # Attack pattern simulation
npm run attackRateLimit # Rate limiting attack simulation
```

### 🏛️ MyData Operator (Enhanced Simulation Environment)

**Dual-Layer Dataset Generation:**

- **Local Detection Algorithm Testing** - Independent algorithm validation datasets
- **Comparative Analysis Data** - Local vs centralized detection comparison
- **Performance Benchmarking** - Algorithm performance and accuracy metrics

**Enhanced Simulation Commands:**

```bash
cd mydata-operator-next

# Local detection algorithm dataset generation
npm run signature       # Local signature detection data
npm run specification  # Local specification detection data
npm run hybrid         # Local hybrid detection data
npm run analysis       # Local detection analysis

# Comparative dataset generation
npm run detect         # Combined local + CA detection comparison
npm run simulate       # Enhanced MyData flow with dual detection
```

## 🔬 Research Capabilities

### Authentication & API Simulation

- **OAuth 2.0 Flow Simulation** - Comprehensive authentication dataset generation
- **Digital Certificate Simulation** - PKI transaction pattern datasets
- **Multi-Bank Authentication Patterns** - Cross-organization interaction datasets

### Dataset Generation & Collection

- **Real-time Traffic Logging** - Live API request/response pattern collection
- **Attack Pattern Datasets** - Comprehensive intrusion attempt records
- **Behavioral Analysis Data** - Normal vs anomalous usage pattern datasets
- **Detection Algorithm Performance** - Accuracy, precision, recall metrics

### Research & Analysis

- **MyData Specification Compliance** - API behavior validation datasets
- **Security Event Correlation** - Multi-source security event datasets
- **Algorithm Performance Benchmarking** - Detection algorithm comparison data
- **Academic Research Support** - Formatted datasets for machine learning research

## 🐳 Docker Operations

### Service Management

```bash
# Start all services
docker-compose up -d

# View service status
docker-compose ps

# View logs
docker-compose logs -f [service-name]

# Restart specific service
docker-compose restart certification-authority

# Stop all services
docker-compose down

# Clean up volumes and networks
docker-compose down -v --remove-orphans
```

### Container Operations

```bash
# Execute commands in containers
docker-compose exec certification-authority bash
docker-compose exec information-provider npm run simulate
docker-compose exec mydata-operator npm run hybrid

# View container logs
docker logs certification-authority
docker logs information-provider
docker logs mydata-operator
```

### Network Configuration

```bash
# Inspect network
docker network inspect mydata-network

# Connect to network
docker network connect mydata-network [container-name]
```

## 🗄️ Database Management

### PostgreSQL Setup

```bash
# Using external PostgreSQL (recommended)
DATABASE_URL="postgresql://user:pass@host:5432/mydata_ca"
DIRECT_URL="postgresql://user:pass@host:5432/mydata_ca"

# For each service, customize database names:
# - mydata_ca (Certification Authority)
# - mydata_ip (Information Provider)
# - mydata_mo (MyData Operator)
```

### Migration Management

```bash
# Run migrations for all services
docker-compose exec certification-authority npx prisma migrate deploy
docker-compose exec information-provider npx prisma migrate deploy
docker-compose exec mydata-operator npx prisma migrate deploy

# Generate Prisma client
docker-compose exec certification-authority npx prisma generate

# View database schema
docker-compose exec certification-authority npx prisma studio
```

### Data Seeding

```bash
# Seed initial data
docker-compose exec certification-authority npm run seedCA
docker-compose exec certification-authority npm run seedOrg
docker-compose exec information-provider npm run seedAccount
docker-compose exec mydata-operator npm run seedAccount
```

## 🧪 Dataset Generation & Simulation

### Dataset Generation Suite

```bash
# Comprehensive dataset generation
cd certification-authority-next
npm run hybrid && npm run analysis

# Attack pattern dataset generation across ecosystem
cd information-provider-next
npm run attack

cd mydata-operator-next
npm run attack && npm run detect
```

### MyData Flow Dataset Generation

```bash
# Complete MyData transaction flow datasets
cd information-provider-next
npm run simulate

# Cross-bank authentication pattern datasets
cd mydata-operator-next
npm run simulate
```

### Performance & Behavior Dataset Generation

```bash
# Rate limiting and behavioral dataset generation
cd certification-authority-next
npm run ratelimit

cd information-provider-next
npm run attackRateLimit
```

## 📈 Dataset Analytics & Research Tools

### Research Dashboard Access

- **Certification Authority Dashboard**: http://localhost:3000/security-dashboard
- **Dataset Collection Monitoring**: Live dataset generation visualization
- **Detection Algorithm Analytics**: Accuracy, precision, recall analysis for research
- **Confusion Matrix Analytics**: Algorithm performance evaluation and comparison

### Dataset Analysis

```bash
# View generated datasets and logs
docker-compose logs -f certification-authority | grep "DETECTION"
docker-compose logs -f information-provider | grep "SIMULATION"
docker-compose logs -f mydata-operator | grep "DATASET"

# Dataset analysis commands
cd certification-authority-next
npm run analysis  # Comprehensive dataset analysis and metrics
```

## 🔧 Configuration

### Environment Variables

**Certification Authority:**

```env
DATABASE_URL="postgresql://localhost:5432/mydata_ca"
JWT_SECRET="your-secure-jwt-secret"
JWT_ISSUER="certification-authority"
JWT_AUDIENCE="mydata-ecosystem"
```

**Information Provider:**

```env
DATABASE_URL="postgresql://localhost:5432/mydata_ip"
CERTIFICATION_AUTHORITY_URL="http://localhost:3000"
ANYA_CLIENT_ID="your-client-id"
ANYA_CLIENT_SECRET="your-client-secret"
```

**MyData Operator:**

```env
DATABASE_URL="postgresql://localhost:5432/mydata_mo"
CERTIFICATION_AUTHORITY_URL="http://localhost:3000"
LOCAL_DETECTION_ENABLED="true"
THREAT_RESPONSE_LEVEL="medium"
```

### Security Configuration

```typescript
// Rate limiting categories
Premium Clients: 30 requests/minute
Standard Clients: 20 requests/minute
Restricted Clients: 10 requests/minute

// Detection thresholds
Signature Detection: Real-time pattern matching
Specification Detection: Schema validation
Hybrid Detection: Combined approach
```

## 🚨 Troubleshooting

### Common Issues

**Services Not Starting:**

```bash
# Check port availability
lsof -i :3000 -i :4000 -i :4200

# Restart Docker services
docker-compose down && docker-compose up --build
```

**Database Connection Issues:**

```bash
# Verify database URLs in .env
echo $DATABASE_URL

# Test database connectivity
docker-compose exec certification-authority npx prisma db push
```

**Authentication Failures:**

```bash
# Verify CA is running
curl http://localhost:3000/health

# Check token validation
curl -H "Authorization: Bearer <token>" http://localhost:4000/api/health
```

## 📚 Additional Resources

### Component Documentation

- [Certification Authority README](./certification-authority-next/README.md) - Central security hub documentation
- [Information Provider README](./information-provider-next/README.md) - Bank API services documentation
- [MyData Operator README](./mydata-operator-next/README.md) - Enhanced security services documentation

### API Documentation

- **OpenAPI Specification**: http://localhost:3000/api-docs
- **Security Patterns**: See `certification-authority-next/scripts/detection-algorithms/security-patterns.ts`
- **Detection Algorithms**: See individual service documentation

### Development

- **Contributing**: See individual service READMEs for development guidelines
- **Testing**: Comprehensive test suites available in each service
- **Deployment**: Docker and manual deployment options documented

---

## 🏆 Research Testbed Highlights

✅ **Comprehensive Dataset Generation** - Multi-algorithm intrusion detection datasets  
✅ **Real-time Data Collection** - Live API traffic pattern recording and analysis  
✅ **MyData Specification Compliance** - Full ecosystem simulation and validation  
✅ **Scalable Research Architecture** - Docker-based microservices for easy deployment  
✅ **Extensive Simulation Capabilities** - Attack pattern generation and behavioral modeling  
✅ **Academic Research Ready** - Structured datasets for machine learning and security research

**🔬 Research Notice**: This testbed is designed for academic research and dataset generation for intrusion detection algorithm development. The generated datasets can be used for training and evaluating machine learning models for API security research.
