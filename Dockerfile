FROM node:20-alpine AS base

# Install dependencies needed for Prisma
RUN apk add --no-cache libc6-compat openssl1.1-compat

WORKDIR /app

# Installing dependencies
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# Building the application
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Running the application
FROM base AS runner
ENV NODE_ENV production

# Create a non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
USER nextjs

COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./package.json
COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma
COPY --from=builder --chown=nextjs:nodejs /app/public ./public

CMD ["npm", "start"] 