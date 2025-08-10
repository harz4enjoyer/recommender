FROM docker.io/library/node:lts-alpine as frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm install
COPY frontend/ .
RUN --mount=type=cache,target=/root/.npm \
    --mount=type=cache,target=/app/frontend/node_modules/.cache \
    npm run build

FROM docker.io/library/rust:latest as backend-builder
WORKDIR /app
COPY backend/ .
RUN --mount=type=cache,target=/app/target \
    --mount=type=cache,target=/usr/local/cargo/registry \
    cargo build --release && \
    cp target/release/recommender /tmp/recommender

FROM docker.io/library/debian
COPY --from=backend-builder /tmp/recommender /recommender
COPY --from=frontend-builder /app/frontend/dist /frontend
ENTRYPOINT ["/recommender", "host = recommender_postgres user = recommender password = recommender", "0.0.0.0:80", "/frontend"]
