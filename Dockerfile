FROM elixir:1.9-alpine

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  ca-certificates \
  gcc \
  git \
  build-base && \
  mix local.rebar --force && \
  mix local.hex --force

ENV RUSTUP_HOME=/usr/local/rustup \
  RUSTFLAGS="-C target-feature=-crt-static" \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH \
  RUST_VERSION=1.40.0

RUN set -eux; \
  url="https://static.rust-lang.org/rustup/archive/1.20.2/x86_64-unknown-linux-musl/rustup-init"; \
  wget "$url"; \
  echo "44d689d8cf49165f059cafe10a5ce49708a26b0b0641169bc0e39ad9c54930d5 *rustup-init" | sha256sum -c -; \
  chmod +x rustup-init; \
  ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
  rm rustup-init; \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
  rustup --version; \
  cargo --version; \
  rustc --version;

