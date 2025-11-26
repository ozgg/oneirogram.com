FROM postgres:18

ARG TARGET_LOCALE=ru_RU.UTF-8

ENV POSTGRES_INITDB_ARGS="--lc-collate=${TARGET_LOCALE} --lc-ctype=${TARGET_LOCALE} --encoding=UTF8"

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && sed -i "s/# ${TARGET_LOCALE} UTF-8/${TARGET_LOCALE} UTF-8/" /etc/locale.gen \
    && locale-gen ${TARGET_LOCALE} \
    && rm -rf /var/lib/apt/lists/*
