FROM phusion/baseimage:0.9.18
MAINTAINER Vo Anh Duy <voanhduy1512@live.come>

CMD ["/sbin/my_init"]


RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && apt-get dist-upgrade -qq -y
RUN apt-get install -qq -y ruby-switch ruby2.3 \
      build-essential ruby2.3-dev libpq-dev \
      nodejs
RUN ruby-switch --set ruby2.3

RUN gem update --system --no-rdoc --no-ri && gem install --no-rdoc --no-ri bundler

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle check || bundle install

ADD . $APP_HOME

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

