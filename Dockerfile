# Use the official n8n image as base
FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a Python virtual environment and install uv
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install uv && \
    ln -s /opt/venv/bin/uv /usr/local/bin/uv && \
    ln -s /opt/venv/bin/uvx /usr/local/bin/uvx

# Make sure the node user can access the virtual environment
RUN chown -R node:node /opt/venv

# Switch back to the node user
USER node

# The rest of the container will use the default n8n entrypoint and command
