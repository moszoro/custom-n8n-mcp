# Stage 1: get uvx binary
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: build final image
FROM n8nio/n8n:latest

USER root

# Install basic tools
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Copy uvx from prebuilt image
COPY --from=uvx-stage /uvx /bin/uvx

# Confirm it's working
RUN uvx --version

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use uvx to install mcp-reddit
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
