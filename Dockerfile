FROM n8nio/n8n:latest

USER root

# base packages + glibc compatibility for uv
RUN apk add --no-cache bash curl git libc6-compat

# install Astral uv directly into /usr/local/bin
# -s -- -b /usr/local/bin  → install script “silent” and copy binary to that dir
RUN curl -Ls https://astral.sh/uv/install.sh | sh -s -- -b /usr/local/bin \
 && ln -s /usr/local/bin/uv /usr/local/bin/uvx   # make uvx alias

ENV PATH="/usr/local/bin:${PATH}"
USER node
