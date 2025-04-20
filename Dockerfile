# Stage 1: Build uvx binary from uv image
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

# Stage 2: Final image with n8n + Node.js + firecrawl-mcp + uvx
FROM n8nio/n8n:latest

# Switch to root to install tools
USER root

# Install dependencies and Node.js
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs python3 python3-pip

# Install global npm package
RUN npm install -g firecrawl-mcp

# Copy uvx binary from previous stage
COPY --from=uvx-stage /uv /uvx /bin/

# Optional: install a package via uvx
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

# Return to non-root user for security
USER node
