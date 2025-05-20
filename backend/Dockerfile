FROM rust:latest as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian
COPY --from=builder /app/target/release/recommender /recommender
ENTRYPOINT ["/recommender"]
