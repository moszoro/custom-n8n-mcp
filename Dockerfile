FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache python3 py3-pip nodejs npm

# Create Python venv and install uv
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install uv \
 && ln -s /opt/venv/bin/uv /usr/local/bin/uv

# Optional: install local n8n
RUN mkdir -p /opt/venv/node \
 && cd /opt/venv/node \
 && npm init -y \
 && npm install n8n

USER node
