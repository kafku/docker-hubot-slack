FROM node:latest

MAINTAINER Kazuki Fukui

USER root

RUN apt-get -q update && \
    apt-get -qy upgrade && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /home/swuser && \
    groupadd -r swuser -g 433 && \
    useradd -u 431 -r -g swuser -d /home/swuser -s /sbin/nologin -c "Docker image user" swuser && \
    chown -R swuser:swuser /home/swuser &&\
    npm install -g yo generator-hubot hubot coffee-script  && \
    npm cache clean

USER swuser
WORKDIR /home/swuser

RUN mkdir myhubot && \
    cd myhubot && \
    yo hubot --defaults && \
    npm install --save hubot-slack hubot-zabbix-notifier hubot-redmine-notifier && \
    npm install && \
    npm cache clean

WORKDIR ./myhubot
COPY external-scripts.json ./external-scripts.json

ENV PORT 9009
EXPOSE 9009

CMD ./bin/hubot --adapter slack
