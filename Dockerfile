FROM surnet/alpine-wkhtmltopdf:3.16.2-0.12.6-full as wkhtmltopdf
FROM webdevops/php-nginx-dev:8.1-alpine


# wkhtmltopdf install dependencies
RUN apk add --no-cache \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl1.1 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    libc6-compat

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /app/vendor/h4cc/wkhtmltopdf-amd64/bin/wkhtmltopdf-amd64
