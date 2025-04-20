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
COPY --from=uvx-stage /uv /bin/uv
COPY --from=uvx-stage /uvx /bin/uvx

# Install CLI tools
RUN npm install -g firecrawl-mcp @smithery/cli

# ✅ Install mcp-reddit safely (no blocking)
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit --entrypoint="echo Installed mcp-reddit"

# Make sure the installed binary path is exposed
ENV PATH="/root/.uvx/bin:$PATH"

USER node
