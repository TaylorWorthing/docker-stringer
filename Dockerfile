FROM ruby:2.3.1-alpine
MAINTAINER BrowncoatShadow "https://github.com/BrowncoatShadow"

RUN apk --no-cache add --virtual .stringer-build \
      git \
      build-base \
      linux-headers && \
    apk --no-cache add \
      curl-dev \
      sqlite-dev \
      libxslt-dev \
      openssl && \
    git clone https://github.com/swanson/stringer.git /stringer

WORKDIR /stringer
COPY . /stringer

RUN git apply patches/*.patch

RUN mkdir /data && \
    echo "$RUBY_VERSION" > .ruby-version && \
    sed -i 's/^  gem "pg".*$/  gem "sqlite3", "~> 1.3", ">= 1.3.8"/' Gemfile && \
    sed -i "/^group :development do/,/^end/d" Gemfile && \
    echo 'gem "rufus-scheduler"' >> Gemfile && \
    echo 'gem "tzinfo-data"' >> Gemfile && \
    sed -i '/^console/d' Procfile && \
    echo 'clock: bundle exec ruby schedule.rb' >> Procfile

RUN bundle config build.nokogiri --use-system-libraries && \
    bundle install --no-cache --without test development && \
    gem install --no-document foreman && \
    apk del .stringer-build

ENV RACK_ENV="production"
EXPOSE 5000
ENTRYPOINT ["/stringer/docker-entrypoint.sh"]
CMD ["foreman", "start"]
