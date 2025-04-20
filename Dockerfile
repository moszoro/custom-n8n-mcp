FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    py3-pipx \
    nodejs \
    npm \
    git

# Install uvx safely via pipx
RUN pipx install uvx && \
    ln -s /root/.local/pipx/venvs/uvx/bin/uvx /usr/local/bin/uvx

# Install npm tools
RUN npm install -g firecrawl-mcp @smithery/cli

# Leave uvx installed, but don’t run MCP yet
ENV PATH="/root/.local/bin:$PATH"

USER node
