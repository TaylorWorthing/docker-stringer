FROM ruby:2.3.1-alpine

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
RUN mkdir /data && \
    sed -i 's/^  gem "pg".*$/  gem "sqlite3", "~> 1.3", ">= 1.3.8"/' Gemfile && \
    sed -i "/^group :development do/,/^end/d" Gemfile && \
    echo "gem 'foreman'" >> Gemfile && \
    echo "gem 'rufus-scheduler'" >> Gemfile && \
    echo "$RUBY_VERSION" > .ruby-version && \
    bundle update && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install --no-cache --deployment && \
    apk del .stringer-build && \
    sed -i "s/^console/#console/" Procfile && \
    echo "clock: ruby schedule.rb" >> Procfile

COPY database.yml config/
COPY schedule.rb .
COPY docker-entrypoint.sh /

ENV RACK_ENV="production"
EXPOSE 5000
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["foreman", "start"]
