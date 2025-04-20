FROM n8nio/n8n:latest
# Switch to root user to install global npm packages
USER root

# Install the desired npm packages globally
RUN --rm -it ghcr.io/astral-sh/uv:debian uv --help
RUN npm install -g firecrawl-mcp
RUN uvx --from git+https://github.com/adhikasp/mcp-reddit.git mcp-reddit

# Revert to the node user for security purposes
USER node
