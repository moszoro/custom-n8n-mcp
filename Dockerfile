FROM n8nio/n8n:latest

USER root

# Install required packages
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

# Confirm Rust is available
RUN rustc --version && cargo --version

# Install uv
RUN cargo install uv

# Confirm uv is available
RUN uv --version

# Install firecrawl-mcp
RUN npm install -g firecrawl-mcp

# Use uv to install mcp-reddit
RUN uv run --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

USER node
