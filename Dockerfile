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
    ttf-liberation \
    autoconf \
    g++ \
    make \
    linux-headers

ARG TARGETARCH
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /app/vendor/h4cc/wkhtmltopdf-${TARGETARCH}/bin/wkhtmltopdf-${TARGETARCH}
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf

COPY --from=wkhtmltopdf /bin/wkhtmltoimage /app/vendor/h4cc/wkhtmltoimage-${TARGETARCH}/bin/wkhtmltoimage-${TARGETARCH}
COPY --from=wkhtmltopdf /bin/wkhtmltoimage /bin/wkhtmltoimage

RUN chmod +x /app/vendor/h4cc/wkhtmltopdf-${TARGETARCH}/bin/wkhtmltopdf-${TARGETARCH}
RUN chmod +x /bin/wkhtmltopdf
RUN chmod +x /bin/wkhtmltoimage

RUN pecl uninstall xdebug \
    && rm -rf /usr/local/lib/php/extensions/no-debug-non-zts-*/xdebug.so \
    && rm -rf /usr/local/lib/php/extensions/no-debug-non-zts-*/xdebug.so.debug

RUN pecl install xdebug-3.2.2 \
    && docker-php-ext-enable xdebug