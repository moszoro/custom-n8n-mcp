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

# ✅ Copy uvx binary into MCP node path
RUN mkdir -p /home/node/.n8n/nodes/node_modules/n8n-nodes-mcp/nodes/McpClient && \
    cp /usr/local/bin/uvx /home/node/.n8n/nodes/node_modules/n8n-nodes-mcp/nodes/McpClient/uvx && \
    chmod +x /home/node/.n8n/nodes/node_modules/n8n-nodes-mcp/nodes/McpClient/uvx && \
    chown -R node:node /home/node/.n8n

# Also keep a symlink in ~/.n8n in case fallback is used
RUN mkdir -p /home/node/.n8n && \
    ln -s /usr/local/bin/uvx /home/node/.n8n/uvx || true && \
    chown -R node:node /home/node/.n8n

# Optional: MCP data directory
RUN mkdir -p /data/mcp && \
    chown -R node:node /data/mcp

# Final path setup
ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

USER node
