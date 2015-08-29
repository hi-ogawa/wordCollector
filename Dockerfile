FROM hiogawa/rails:v1
MAINTAINER Hiroshi Ogawa <hi.ogawa.zz@gmail.com>
COPY ./railsAPI /code
WORKDIR /code
RUN git config --global url."https://github.com".insteadOf git://github.com
RUN eval "$(rbenv init -)" && \
    rbenv rehash           && \
    bundle install         && \
    rbenv rehash
EXPOSE 80
CMD eval "$(rbenv init -)" && \
    export SECRET_KEY_BASE="$(rake secret)"
    passenger start s -p 80 -e production
