# ── Stage 1 ───────────────────────────────────────────────
FROM ghcr.io/astral-sh/uv:latest AS uvstage    # contains both uv and uvx

# ── Final n8n image ──────────────────────────────────────
FROM n8nio/n8n:latest

USER root

RUN apk add --no-cache bash curl git libc6-compat

# copy the binaries
COPY --from=uvstage /uv  /usr/local/bin/uv
COPY --from=uvstage /uvx /usr/local/bin/uvx
RUN chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

ENV PATH="/usr/local/bin:${PATH}"
USER node
