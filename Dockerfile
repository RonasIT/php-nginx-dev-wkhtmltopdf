FROM --platform=$BUILDPLATFORM surnet/alpine-wkhtmltopdf:3.20.0-0.12.6-full AS wkhtmltopdf
FROM --platform=$BUILDPLATFORM webdevops/php-nginx-dev:8.3-alpine

# wkhtmltopdf install dependencies
RUN apk add --no-cache \
    libstdc++ \
    libc6-compat \
    libx11 \
    libxrender \
    libxext \
    libssl3 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-droid \
    ttf-freefont \
    ttf-liberation

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /app/vendor/h4cc/wkhtmltopdf-amd64/bin/wkhtmltopdf-amd64
