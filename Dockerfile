FROM surnet/alpine-wkhtmltopdf:3.20.2-0.12.6-full as wkhtmltopdf
FROM webdevops/php-nginx:8.4-alpine

ENV WEB_DOCUMENT_ROOT /app/public
ENV WEB_DOCUMENT_INDEX index.php

RUN apk add --no-cache \
    libstdc++ \
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

WORKDIR /app
COPY --chown=1000:1000 . /app/
RUN composer install --optimize-autoloader

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf