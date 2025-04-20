FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache bash curl git build-base chromium tar xz util-linux coreutils libc6-compat

# install uv + uvx
RUN curl -Ls https://astral.sh/uv/install.sh | bash \
 && cp /root/.local/bin/uv* /usr/local/bin/ \
 && chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

USER node
