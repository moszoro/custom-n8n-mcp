# Stage 1: Grab uvx binary from UV image
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: Build n8n with required tools
FROM n8nio/n8n:latest

USER root

# Install dependencies using Alpine package manager
RUN apk add --no-cache \
    curl \
    nodejs \
    npm \
    python3 \
    py3-pip

# Install firecrawl-mcp globally
RUN npm install -g firecrawl-mcp

# Copy uv and uvx binaries from stage
COPY --from=uvx-stage /uv /uvx /bin/

# Install mcp-reddit using uvx
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

# Switch back to non-root user
USER node
