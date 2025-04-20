# Add uvx (copy from prebuilt image)
FROM ghcr.io/astral-sh/uv:latest as uvx-stage

FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    nodejs \
    npm \
    git

# Copy uv and uvx binaries
COPY --from=uvx-stage /uv /bin/uv
COPY --from=uvx-stage /uvx /bin/uvx

# Install CLI tools
RUN npm install -g firecrawl-mcp @smithery/cli

# ✅ Install mcp-reddit via uvx, no run
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit --help || true

# ✅ Ensure installed tool path is visible
ENV PATH="/root/.uvx/bin:$PATH"

USER node
