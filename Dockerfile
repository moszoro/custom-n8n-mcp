FROM n8nio/n8n:latest

USER root

# tools needed by installer + glibc compatibility for uv
RUN apk add --no-cache bash curl git tar xz libc6-compat

# download installer, run with bash, place binary into /usr/local/bin
RUN curl -Ls https://astral.sh/uv/install.sh -o /tmp/install_uv.sh \
 && bash /tmp/install_uv.sh -b /usr/local/bin \
 && ln -s /usr/local/bin/uv /usr/local/bin/uvx \
 && rm /tmp/install_uv.sh

ENV PATH="/usr/local/bin:${PATH}"
USER node
