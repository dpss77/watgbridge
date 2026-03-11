# Single-stage build — keeps the full Go toolchain in the final image.
# watgbridge checks for git, go, ffmpeg, imagemagick, webp-tools at startup;
# this avoids the multi-stage copy whack-a-mole game entirely.
FROM golang:1.26-alpine

RUN apk --no-cache add \
    gcc g++ make \
    git \
    tzdata \
    ffmpeg \
    imagemagick \
    libwebp-tools

WORKDIR /go/src/watgbridge
COPY go.mod go.sum ./
RUN go mod download

COPY . ./
RUN go build

CMD ["./watgbridge"]
