# ── Stage 1 ───────────────────────────────────────────────
FROM ghcr.io/astral-sh/uv:latest AS uvstage

# ── Final n8n image ──────────────────────────────────────
FROM n8nio/n8n:latest
USER root

RUN apk add --no-cache bash curl git libc6-compat

# copy only the uv binary
COPY --from=uvstage /usr/local/bin/uv /usr/local/bin/uv

# ── create an alias called uvx ───────────────────────────
RUN ln -s /usr/local/bin/uv /usr/local/bin/uvx        \
 && chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

ENV PATH="/usr/local/bin:${PATH}"
USER node
