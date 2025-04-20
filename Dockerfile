FROM n8nio/n8n:latest

USER root

# Install required packages
RUN apk add --no-cache \
    curl \
    nodejs \
    npm \
    python3 \
    py3-pip \
    bash

# Install uv (this installs uvx into /root/.cargo/bin)
RUN curl -Ls https://astral.sh/uv/install.sh | bash

# Add uvx to PATH explicitly
ENV PATH="/root/.cargo/bin:${PATH}"

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Install mcp-reddit using uvx
RUN /root/.cargo/bin/uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
