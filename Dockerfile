FROM debian
MAINTAINER Albert Dixon <albert@dixon.rocks>

EXPOSE 2025
WORKDIR /bitcannon
ENTRYPOINT ["tini", "-g", "--", "entry.sh"]
RUN apt-get update \
    && apt-get install -y ca-certificates \
    && useradd -M bc \
    && usermod -L bc \
    && chown -R bc:bc /bitcannon \
    && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://github.com/krallin/tini/releases/download/v0.8.4/tini /bin/
ADD https://github.com/albertrdixon/tmplnator/releases/download/v2.2.1/t2-linux.tgz /t2.tgz
ADD entry.sh /sbin/
RUN tar xvzf /t2.tgz -C /bin && rm -f /t2.tgz \
    && chmod +x /bin/tini /sbin/entry.sh

USER bc
ADD config.json.tmpl  /templates/
ADD bitcannon-v0.1.1  /bitcannon/bitcannon

ENV USER_HASH=examplehash \
    MONGO_HOST=mongo
