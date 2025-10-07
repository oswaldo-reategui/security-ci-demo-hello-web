# 1) Base stage: generate lockfile, install deps, copy source
FROM node:18-alpine AS base
WORKDIR /app

# Copy only package manifests first
COPY package.json package-lock.json* ./

# If no lockfile is present in the context, generate one inside the image
# (This keeps host clean and still allows reproducible installs afterwards)
RUN [ -f package-lock.json ] || npm install --package-lock-only

# Do a clean, reproducible install using the freshly created lockfile
RUN npm ci

# Now copy the rest of the source
COPY . .

# 2) Dev runtime (keeps devDependencies for lint/test/audit)
FROM base AS dev
EXPOSE 3000
CMD ["npm","start"]

# 3) Test runner (separate target so you can run tests in isolation)
FROM base AS test
CMD ["npm","test"]

# 4) Production image (optional)
FROM node:18-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json ./
RUN npm ci --omit=dev
COPY src ./src
EXPOSE 3000
CMD ["node","src/server.js"]
