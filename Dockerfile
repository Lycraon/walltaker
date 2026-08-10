FROM ruby:3.3.4

# Prepare working directory.
WORKDIR /ror
COPY ./ /ror
RUN gem install bundler
RUN bundle install
RUN SECRET_KEY_BASE=asset_precompile_secret REDIS_URL=redis://localhost:6379/1 RAILS_ENV=production bundle exec rails assets:precompile

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Start app server.
CMD ["bundle", "exec", "rails", "server", "-e", "production", "-b", "0.0.0.0"]