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

# Install uv (includes `uv run`)
RUN curl -Ls https://astral.sh/uv/install.sh | bash

# Add uv to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Optional: show what's installed (for debug)
RUN ls -l /root/.cargo/bin

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use `uv run` instead of `uvx`
RUN uv run --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
