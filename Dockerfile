FROM debian:jessie
MAINTAINER Albert Dixon <albert@dixon.rocks>

EXPOSE 2025
CMD ["bitcannon/bitcannon"]
RUN useradd -M bc \
    && usermod -L bc \
    && mkdir /bitcannon \
    && chown -R bc:bc bitcannon
USER bc
ADD config.json bitcannon/
ADD bitcannon-v0.1.1 bitcannon/bitcannon