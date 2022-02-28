FROM golang:1.17
COPY . $GOPATH/src/test/
WORKDIR $GOPATH/src/test/
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app

FROM alpine:latest
WORKDIR /
RUN apk --no-cache add ca-certificates
COPY --from=0 /app /app
ENTRYPOINT ["/app"]