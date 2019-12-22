FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# for capybara-webkit gem
RUN apt-get install -y g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
RUN apt-get install -y xvfb xserver-xephyr vnc4server

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:1.14.4
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY .docker_development/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
