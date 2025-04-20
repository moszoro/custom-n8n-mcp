FROM n8nio/n8n:latest

USER root

# Install required packages
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Install global npm tools
RUN npm install -g firecrawl-mcp @smithery/cli n8n-nodes-mcp

USER node
