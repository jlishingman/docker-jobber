FROM ruby:2.3.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# setup ssh for git
RUN mkdir /root/.ssh/
# copy private key
ADD id_rsa /root/.ssh/id_rsa
#ADD /Users/jlishingman/.ssh/id_rsa /root/.ssh/id_rsa
# Add github's key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN mkdir /Jobber
WORKDIR /Jobber
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle install
ADD . /Jobber
