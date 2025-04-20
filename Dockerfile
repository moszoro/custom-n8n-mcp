# Stage 1: Get prebuilt uv binary
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: Build your n8n image
FROM n8nio/n8n:latest

USER root

# Install system dependencies
RUN apk add --no-cache \
    bash \
    curl \
    nodejs \
    npm \
    python3 \
    py3-pip \
    git

# Copy uv binary from uv image
COPY --from=uvx-stage /uv /bin/uv

# Optional: check it's there
RUN uv --version

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use uv run (replaces uvx)
RUN uv run --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
