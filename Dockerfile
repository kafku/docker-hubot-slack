FROM node:latest

MAINTAINER Kazuki Fukui

ENV HS_VERSION 3.4.1
RUN apt-get -q update && \
    apt-get -qy --no-install-recommends install wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yo generator-hubot coffee-script hubot-zabbix-notifier hubot-redmine-notifier && \
    npm cache clean && \
    wget --no-check-certificate https://github.com/slackhq/hubot-slack/archive/v${HS_VERSION}.tar.gz && \
    tar xf v${HS_VERSION}.tar.gz && \
    rm -rf v${HS_VERSION}.tar.gz

WORKDIR /hubot-slack-{SLACKHQ_VERSION}

RUN npm install

CMD ./bin/hubot --adapter slack
