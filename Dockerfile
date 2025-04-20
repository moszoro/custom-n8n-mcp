FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git \
    build-base

# Install pipx and uvx cleanly
RUN python3 -m venv /venv && \
    /venv/bin/pip install pipx && \
    /venv/bin/pipx install uvx && \
    ln -s /root/.local/pipx/venvs/uvx/bin/uvx /usr/local/bin/uvx

# Optional: verify
RUN uvx --version || echo "uvx failed"

# Install global npm tools
RUN npm install -g firecrawl-mcp @smithery/cli

USER node
