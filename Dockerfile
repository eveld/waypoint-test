FROM golang:1.16 AS build
COPY main.go ./
RUN go build -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
COPY --from=build /go/src/app ./
CMD ["./app"]  