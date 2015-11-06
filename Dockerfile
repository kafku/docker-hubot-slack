FROM node:latest

MAINTAINER Kazuki Fukui

ENV SLACKHQ_VERSION 3.4.1
RUN apt-get -q update && \
    apt-get -qy --no-install-recommends install wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yo generator-hubot coffee-script hubot-zabbix-notifier hubot-redmine-notifier && \
    npm cache clean && \
    wget --no-check-certificate https://github.com/slackhq/hubot-slack/archive/v${SLACKHQ_VERSION}.tar.gz && \
    tar xf v${SLACKHQ_VERSION}.tar.gz && \
    rm -rf v${SLACKHQ_VERSION}.tar.gz

WORKDIR /hubot-slack-{SLACKHQ_VERSION}

RUN npm install

CMD ./bin/hubot --adapter slack
