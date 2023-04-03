FROM golang:alpine3.17 AS builder

# Installing git for go dependencies
RUN apk add git

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY main.go ./
RUN go build -o main

FROM alpine:latest

WORKDIR /app

COPY --from=builder /build/main .

EXPOSE 8000

CMD ["./main"]