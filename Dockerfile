FROM node:lts-alpine as frontend-builder
WORKDIR /app/frontend
COPY frontend/ .
RUN npm install
RUN npm run build

FROM rust:latest as backend-builder
WORKDIR /app
COPY backend/ .
RUN --mount=type=cache,target=/app/target \
    --mount=type=cache,target=/usr/local/cargo/registry \
    cargo build --release && \
    cp target/release/recommender /tmp/recommender

FROM debian
COPY --from=backend-builder /tmp/recommender /recommender
COPY --from=frontend-builder /app/frontend/dist /frontend
ENTRYPOINT ["/recommender"]
