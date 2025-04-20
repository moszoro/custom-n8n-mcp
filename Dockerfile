# Stage 1: Get uvx binary
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Final image
FROM n8nio/n8n:latest

USER root

# Install required tools
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Copy uv and uvx to global bin
COPY --from=uvx-stage /uv /usr/local/bin/uv
COPY --from=uvx-stage /uvx /usr/local/bin/uvx

# Make sure binaries are executable
RUN chmod +x /usr/local/bin/uv /usr/local/bin/uvx

# Also symlink uvx inside .n8n in node user's home
RUN mkdir -p /home/node/.n8n && \
    ln -s /usr/local/bin/uvx /home/node/.n8n/uvx && \
    chown -R node:node /home/node/.n8n

# Install CLI tools
RUN npm install -g firecrawl-mcp

# Expose path (already default, but explicit)
ENV PATH="/usr/local/bin:$PATH"

# Switch back to non-root user
USER node
