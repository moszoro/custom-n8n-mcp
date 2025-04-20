# Stage 1: Get uv + uvx from official prebuilt image
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: n8n + tools
FROM n8nio/n8n:latest

USER root

# Install required packages
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Copy uv and uvx binaries
COPY --from=uvx-stage /uv /bin/uv
COPY --from=uvx-stage /uvx /bin/uvx

# Check if uvx works
RUN uvx --version

# Install firecrawl-mcp globally
RUN npm install -g firecrawl-mcp

USER node
