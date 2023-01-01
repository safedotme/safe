FROM golang:1.19.4-alpine3.16
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main .
CMD [ "/app/main" ]
