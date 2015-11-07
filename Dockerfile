FROM node:latest

MAINTAINER Kazuki Fukui

WORKDIR /root

RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yo generator-hubot hubot coffee-script  && \
    mkdir myhubot && \
    cd myhubot && \
    yo hubot && \
    npm install --save hubot-slack hubot-zabbix-notifier hubot-redmine-notifier && \
    npm install && \
    npm cache clean

WORKDIR ./myhubot
COPY external-scripts.json ./external-scripts.json

ENV PORT 9009
EXPOSE 9009

CMD ./bin/hubot --adapter slack
