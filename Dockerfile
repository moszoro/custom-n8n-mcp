FROM n8nio/n8n:latest

USER root

# Install system tools
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git \
    build-base

# Install pipx inside virtualenv and install uvx
RUN python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip install pipx && \
    /venv/bin/pipx install uvx && \
    ln -s /root/.local/pipx/venvs/uvx/bin/uvx /usr/local/bin/uvx

# Install global npm tools
RUN npm install -g firecrawl-mcp @smithery/cli

# Add pipx bin path for safety
ENV PATH="/root/.local/bin:$PATH"

USER node
