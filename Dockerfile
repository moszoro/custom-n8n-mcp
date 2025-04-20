FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    bash \
    curl \
    nodejs \
    npm \
    python3 \
    py3-pip \
    git

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Install mcp-reddit using pipx
RUN pip install pipx && \
    pipx install git+https://github.com/adhikasp/mcp-reddit.git

USER node
