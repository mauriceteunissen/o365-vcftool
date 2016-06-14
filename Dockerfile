FROM ruby:2.1
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
#RUN npm install -g phantomjs

RUN mkdir /myapp

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /myapp
WORKDIR /myapp
RUN bundle exec rake db:setup
#RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
EXPOSE 3000
CMD ["rails","server","-b","0.0.0.0"]