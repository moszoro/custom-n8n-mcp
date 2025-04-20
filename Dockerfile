FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache python3 py3-pip nodejs npm

# Create a Python virtual environment and install uv
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install uv

# Optional: create a Node project inside venv for isolated n8n
RUN mkdir -p /opt/venv/node \
 && cd /opt/venv/node \
 && npm init -y \
 && npm install n8n

# Add both Python venv and local node_modules/.bin to PATH
ENV PATH="/opt/venv/bin:/opt/venv/node/node_modules/.bin:$PATH"

USER node
