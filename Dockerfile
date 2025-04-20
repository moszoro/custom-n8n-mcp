FROM n8nio/n8n:latest

USER root

# Install necessary system packages
RUN apk add --no-cache \
    curl \
    git \
    build-base \
    chromium \
    bash \
    tar \
    xz \
    util-linux \
    coreutils \
    libc6-compat

# Install Astral uv/uvx and make available system-wide
RUN curl -Ls https://astral.sh/uv/install.sh | bash \
    && cp /root/.local/bin/uv /usr/local/bin/uv \
    && cp /root/.local/bin/uvx /usr/local/bin/uvx \
    && chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

# Optional: MCP working directory (owned by node)
RUN mkdir -p /data/mcp && \
    chown -R node:node /data/mcp

# ✅ Fix: symlink uvx to ~/.n8n/uvx so mcpClient can find it
RUN mkdir -p /home/node/.n8n && \
    ln -s /usr/local/bin/uvx /home/node/.n8n/uvx && \
    chown -R node:node /home/node/.n8n

# Just to be safe
ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

USER node
