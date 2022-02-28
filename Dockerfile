FROM golang:1.16 AS build
WORKDIR /go/src/github.com/eveld/waypoint-test/
COPY . ./
RUN go build -o app ./...

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
COPY --from=build /go/src/github.com/eveld/waypoint-test/app /app
CMD ["/app"]