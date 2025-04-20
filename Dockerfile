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

# Copy uv and uvx
COPY --from=uvx-stage /uv /usr/local/bin/uv
COPY --from=uvx-stage /uvx /usr/local/bin/uvx

# Make sure binaries are executable
RUN chmod +x /usr/local/bin/uv /usr/local/bin/uvx

# Install CLI tools
RUN npm install -g firecrawl-mcp

# Ensure PATH includes the location (already default, just for clarity)
ENV PATH="/usr/local/bin:$PATH"

# Switch back to non-root user (node)
USER node
