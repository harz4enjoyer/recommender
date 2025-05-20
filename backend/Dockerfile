FROM node:lts-alpine as frontend-builder
WORKDIR /app/frontend
COPY frontend/ .
RUN npm install
RUN npm run build

FROM rust:latest as backend-builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian
COPY --from=backend-builder /app/target/release/recommender /recommender
COPY --from=frontend-builder /app/frontend/dist /frontend
ENTRYPOINT ["/recommender"]
