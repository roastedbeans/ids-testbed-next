# TyperError: fetch failed - Fix Summary

## Issue Description

The Docker containers were experiencing a "TypeError: fetch failed" error when trying to make API requests between services. This was occurring in the certification-authority service when trying to communicate with the other services.

## Root Cause

The main cause of the issue was in the docker-compose.yml configuration:

1. Environment variables were using `${DATABASE_URL}` format which might not have been properly resolved at runtime
2. The Next.js client-side code was trying to fetch from internal container hostnames, which aren't accessible from the browser

## Solution Applied

1. Changed database connection strings to use explicit values:

   ```yaml
   DATABASE_URL: postgresql://postgres:postgres@mydata-postgres:5432/mydata
   DIRECT_URL: postgresql://postgres:postgres@mydata-postgres:5432/mydata
   ```

2. Updated NEXT*PUBLIC*\* variables to use localhost URLs for client-side requests:

   ```yaml
   # Changed from:
   NEXT_PUBLIC_BOND_BANK_API: http://mydata-operator:4200
   NEXT_PUBLIC_ANYA_BANK_API: http://information-provider:4000

   # Changed to:
   NEXT_PUBLIC_BOND_BANK_API: http://localhost:4200
   NEXT_PUBLIC_ANYA_BANK_API: http://localhost:4000
   ```

3. Kept server-side URLs using container names for internal communication:
   ```yaml
   BOND_BANK_API: http://mydata-operator:4200
   ANYA_BANK_API: http://information-provider:4000
   ```

## Explanation

The issue stemmed from a common Docker networking challenge:

- **Server-side requests**: In Node.js server code, service URLs should reference the internal Docker network names (e.g., `http://information-provider:4000`)
- **Client-side requests**: In browser JavaScript, service URLs must use the externally accessible endpoints (e.g., `http://localhost:4000`)

Next.js prefixes client-side environment variables with `NEXT_PUBLIC_`, so the fix involved ensuring:

1. Regular env vars (for server-side code) use container names
2. NEXT*PUBLIC*\* vars (for client-side code) use localhost URLs

## Verification

After these changes were applied:

1. The fetch errors no longer appear in logs
2. The security dashboard is loading correctly
3. All services can communicate with each other

## Notes for Future Maintenance

When adding new services or modifying existing ones:

1. Always keep server-side and client-side URLs separated in your environment variables
2. For server-to-server communication within Docker, use the service name as the hostname
3. For client-to-server communication, use either localhost or the public-facing domain
4. Use explicit database connection strings rather than relying on variable interpolation
