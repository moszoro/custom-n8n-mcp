FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache bash curl git tar

# download the static musl build, move the uv binary into /usr/local/bin
RUN set -e \
 && curl -L "https://github.com/astral-sh/uv/releases/latest/download/uv-$(uname -m)-unknown-linux-musl.tar.gz" \
      -o /tmp/uv.tar.gz \
 && tar -xzf /tmp/uv.tar.gz -C /tmp \
 && mv /tmp/uv*/uv /usr/local/bin/uv \
 && ln -s /usr/local/bin/uv /usr/local/bin/uvx \
 && chmod +x /usr/local/bin/uv /usr/local/bin/uvx \
 && rm -rf /tmp/uv*

ENV PATH="/usr/local/bin:${PATH}"
USER node
