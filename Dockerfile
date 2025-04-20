# ── Stage 1 ───────────────────────────────────────────────
FROM ghcr.io/astral-sh/uv:latest AS uvstage

# ── Final n8n image ──────────────────────────────────────
FROM n8nio/n8n:latest

USER root

# packages needed by n8n + uvx (musl‑based binary needs libc6‑compat)
RUN apk add --no-cache bash curl git libc6-compat

# copy uv and uvx from the first stage
COPY --from=uvstage /uv  /usr/local/bin/uv
COPY --from=uvstage /uvx /usr/local/bin/uvx
RUN chmod a+rx /usr/local/bin/uv /usr/local/bin/uvx

ENV PATH="/usr/local/bin:${PATH}"

USER node
