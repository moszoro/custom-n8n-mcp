FROM n8nio/n8n:latest

# Switch to root to install dependencies
USER root

# Install system packages
RUN apk add --no-cache \
    curl \
    nodejs \
    npm \
    python3 \
    py3-pip \
    bash

# Install uv manually
RUN curl -Ls https://astral.sh/uv/install.sh | bash
ENV PATH="/root/.cargo/bin:${PATH}"

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Install mcp-reddit via uvx
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

# Return to non-root user for security
USER node
