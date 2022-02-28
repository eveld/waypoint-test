FROM golang:1.16 AS build
COPY . $GOPATH/src/test/
WORKDIR $GOPATH/src/test/
RUN go get -d -v
RUN go build -o /go/bin/app

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
COPY --from=build /go/bin/app /app
ENTRYPOINT ["/app"]