FROM n8nio/n8n:latest

USER root

# Install required system tools
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Install pipx and uvx
RUN pip install pipx --break-system-packages && \
    pipx ensurepath && \
    pipx install uvx && \
    ln -s /root/.local/pipx/venvs/uvx/bin/uvx /usr/local/bin/uvx

# Install CLI tools
RUN npm install -g firecrawl-mcp

# Add pipx binary path to global PATH
ENV PATH="/root/.local/bin:$PATH"

# ✅ Don't run mcp-reddit now — install it later at runtime (or in start command)
USER node
