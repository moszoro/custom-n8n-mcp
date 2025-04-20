# Stage 1: Get uvx binary
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Final image with n8n
FROM n8nio/n8n:latest

USER root

# Install required tools and compatibility libs
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git \
    libc6-compat

# Copy uv and uvx to global bin
COPY --from=uvx-stage /uv /usr/local/bin/uv
COPY --from=uvx-stage /uvx /usr/local/bin/uvx

# Ensure binaries are executable
RUN chmod +x /usr/local/bin/uv /usr/local/bin/uvx

# Symlink uvx to .n8n directory for node user access (if node tries to load from there)
RUN mkdir -p /home/node/.n8n && \
    ln -s /usr/local/bin/uvx /home/node/.n8n/uvx && \
    chown -R node:node /home/node/.n8n

# Install firecrawl CLI globally
RUN npm install -g firecrawl-mcp

# Just in case, add /usr/local/bin explicitly to path
ENV PATH="/usr/local/bin:$PATH"

USER node
