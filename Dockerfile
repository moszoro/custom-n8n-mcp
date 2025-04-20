FROM n8nio/n8n:latest
# Switch to root user to install global npm packages
USER root
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs
# Install the desired npm packages globally
FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN npm install -g firecrawl-mcp
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

# Revert to the node user for security purposes
USER node
