FROM node:latest

MAINTAINER Kazuki Fukui

ENV HS_VERSION 3.4.1
RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -qy --no-install-recommends install wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yo generator-hubot coffee-script  && \
    npm cache clean

WORKDIR /hubot-slack-{SLACKHQ_VERSION}
RUN npm install && \
    npm install hubot-zabbix-notifier hubot-redmine-notifier && \
    mpn cache clean
COPY external-scripts.json ./external-scripts.json

CMD ./bin/hubot --adapter slack
