FROM ubuntu
RUN apt-get update 

RUN apt-get -y update 
RUN apt-get -y install git git-core curl gawk g++ gcc make libc6-dev libreadline6-dev \  
	zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf \  
	libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev

RUN apt-get install -y postgresql postgresql-contrib postgresql-client libpq5 libpq-dev
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -  

RUN curl -L https://get.rvm.io | bash -s stable 
	
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rvm install ruby-2.1.5   
RUN rvm reload
CMD source /etc/profile 
CMD source /usr/local/rvm/scripts/rvm
RUN apt-get install -y nodejs npm  
RUN ln -s  /usr/bin/nodejs  /usr/bin/node 
RUN ["/bin/bash", "-l", "-c", "rvm use 2.1.5 --default" ]
RUN ["/bin/bash", "-l", "-c", "rvm requirements; gem install bundler --no-ri --no-rdoc"]
RUN ["/bin/bash", "-l", "-c", "gem list"]
FROM alok/ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
RUN ["/bin/bash", "-l", "-c", "bundle install "]