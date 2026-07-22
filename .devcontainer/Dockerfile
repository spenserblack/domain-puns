ARG VARIANT="3-resolute"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}
ARG GLEAM="1.17.0"
RUN \
    apt-get update \
    && apt-get install --yes erlang-dev rebar3 \
    && curl -fsSL https://github.com/gleam-lang/gleam/releases/download/v${GLEAM}/gleam-v${GLEAM}-x86_64-unknown-linux-musl.tar.gz | tar -C /usr/local/bin/ -xzf -
