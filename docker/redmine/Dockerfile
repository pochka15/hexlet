FROM ruby
COPY . /app
WORKDIR /app
RUN gem install bundler
RUN bundle install

# This is a step 8 form the tutorial: https://www.redmine.org/projects/redmine/wiki/RedmineInstall
RUN mkdir -p tmp tmp/pdf public/plugin_assets
