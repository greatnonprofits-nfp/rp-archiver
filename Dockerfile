FROM golang:1.13

WORKDIR /app

RUN apk update \
  && apk add --virtual build-deps gcc git \
  && rm -rf /var/cache/apk/*

RUN addgroup -S ccl_archiver \
  && adduser -S -G ccl_archiver ccl_archiver

COPY . .

RUN go install -v ./cmd/...
RUN chown -R ccl_archiver /app

USER ccl_archiver

EXPOSE 80
ENTRYPOINT ["rp-archiver"]