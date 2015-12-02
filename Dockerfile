FROM debian:jessie
MAINTAINER Albert Dixon <albert@dixon.rocks>

EXPOSE 2025
WORKDIR /bitcannon
CMD ["bitcannon"]
RUN useradd -M bc \
    && usermod -L bc \
    && chown -R bc:bc /bitcannon
USER bc
ADD config.json /bitcannon/
ADD bitcannon-v0.1.1 /bitcannon/bitcannon