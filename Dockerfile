# Stage 1: grab prebuilt uvx binary
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: n8n with uvx and other stuff
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

# Copy uvx binary from the uv image
COPY --from=uvx-stage /uvx /bin/uvx

# Check it's working
RUN uvx --help

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use uvx to install mcp-reddit
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
