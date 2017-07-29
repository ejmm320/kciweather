FROM ruby:2.4

RUN apt-get update && apt-get install -y build-essential nodejs

RUN mkdir -p /kciweather
WORKDIR /kciweather

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . ./

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb

