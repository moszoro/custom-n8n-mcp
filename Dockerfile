FROM n8nio/n8n:latest

USER root

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    gcc \
    musl-dev \
    libc-dev \
    nodejs \
    npm \
    git \
    openssl \
    build-base

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install uv from GitHub repo
RUN cargo install --git https://github.com/astral-sh/uv uv --locked

# Confirm it's there
RUN uv --version

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Install mcp-reddit via uv
RUN uv run --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
