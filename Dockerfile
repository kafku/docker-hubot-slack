FROM node:latest

MAINTAINER Kazuki Fukui

RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g hubot coffee-script  && \
    hubot --create myhubot && \
    cd myhubot && \
    npm install --save hubot-slack hubot-zabbix-notifier hubot-redmine-notifier && \
    npm install && \
    npm cache clean

WORKDIR /myhubot
COPY external-scripts.json ./external-scripts.json

CMD ./bin/hubot --adapter slack
