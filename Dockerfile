# use ruby version
FROM ruby:2.7.2

# using japanese on rails console
ENV LANG C.UTF-8

# remove warn
ENV DEBCONF_NOWARNINGS yes
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV XDG_CACHE_HOME /tmp

# install package to docker container
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    vim \
    less

# install yarn & nodejs
# https://github.com/docker/for-mac/issues/5864
RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg 
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn postgresql-client

# remove pubkey 
RUN rm pubkey.gpg

# setting environment value
ENV HOME /app

# setting work directory
RUN mkdir $HOME
WORKDIR $HOME

# executing bundle install
COPY Gemfile $HOME/Gemfile
COPY Gemfile.lock $HOME/Gemfile.lock

# bundle install
RUN bundle install
COPY . $HOME

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
