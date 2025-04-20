FROM n8nio/n8n:latest

USER root

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Install npm tools
RUN npm install -g firecrawl-mcp @smithery/cli

# Clone mcp-reddit manually instead of using uvx
RUN git clone https://github.com/adhikasp/mcp-reddit.git /mcp-reddit

# Make sure the path is visible
ENV PATH="/mcp-reddit:$PATH"

USER node
