FROM n8nio/n8n:latest

USER root

# tools needed for download / extract
RUN apk add --no-cache curl tar git

# grab latest musl build, unpack just the binary
RUN curl -L "https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-unknown-linux-musl.tar.gz" \
        -o /tmp/uv.tar.gz \
 && tar -xzf /tmp/uv.tar.gz -C /usr/local/bin uv \
 && ln -s /usr/local/bin/uv /usr/local/bin/uvx \
 && chmod +x /usr/local/bin/uv /usr/local/bin/uvx \
 && rm /tmp/uv.tar.gz

ENV PATH="/usr/local/bin:${PATH}"
USER node
