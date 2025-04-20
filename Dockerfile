FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache python3 py3-pip nodejs npm

# Create a Python virtual environment and install uv
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install uv

# Add Python venv (for uv) to PATH
ENV PATH="/opt/venv/bin:$PATH"

# Optional: install n8n in isolated node_modules
RUN mkdir -p /opt/venv/node \
 && cd /opt/venv/node \
 && npm init -y \
 && npm install n8n

# Add local node_modules/.bin (for n8n) to PATH
ENV PATH="/opt/venv/node/node_modules/.bin:$PATH"

USER node
