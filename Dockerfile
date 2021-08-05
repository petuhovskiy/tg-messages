FROM golang:1.16.3-buster AS go-builder

WORKDIR /usr/src/app

#RUN apk add --update \
#        curl \
#        gcc \
#        git \
#        make \
#        musl-dev

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN cd cmd/tgm && go build -o /app


FROM debian:buster

# Install packages required by the image
#RUN apk add --update \
#        bash \
#        ca-certificates \
#        coreutils \
#        curl \
#        jq \
#        openssl \
#    && rm /var/cache/apk/*

COPY --from=go-builder /app ./

CMD [ "./app" ]
