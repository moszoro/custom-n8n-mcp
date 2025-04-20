FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache python3 py3-pip nodejs npm

RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install uv \
 && ln -s /opt/venv/bin/uv /usr/local/bin/uv
USER node
