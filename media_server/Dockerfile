FROM golang:1.19
RUN mkdir /build
ADD . /build

# Build server
WORKDIR /build
RUN go build -o main .

# Install FFMPEG
RUN apt-get -y update
RUN apt-get install -y ffmpeg

# Run server
CMD [ "/build/main" ]
EXPOSE 8080