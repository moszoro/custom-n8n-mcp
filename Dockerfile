FROM n8nio/n8n:latest

USER root

# Install required packages
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    gcc \
    musl-dev \
    libc-dev \
    nodejs \
    npm \
    git \
    openssl

# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | bash

# Add to path
ENV PATH="/root/.cargo/bin:${PATH}"

# Debug: show installed binaries
RUN ls -l /root/.cargo/bin

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use uv run to install mcp-reddit
RUN uv run --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
