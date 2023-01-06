FROM golang:1.19.4-alpine3.16
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN go build -o main .
CMD [ "/build/main" ]
EXPOSE 8080