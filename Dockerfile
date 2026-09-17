FROM golang:1.26 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:3.19
WORKDIR /app
COPY --from=build /app/app .
COPY --from=build /app/tracker.db .
CMD ["./app"]