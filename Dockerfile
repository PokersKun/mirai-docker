FROM adoptopenjdk/openjdk11-openj9:alpine-jre
EXPOSE 8080
WORKDIR /app
RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache procps unzip curl bash tzdata \
	&& apk add ffmpeg \
	&& apk add python3 \
    && ln -s /usr/bin/python3 /usr/bin/python
RUN wget -O mcl.zip https://github.com/iTXTech/mirai-console-loader/releases/download/v1.2.3/mcl-1.2.3.zip && unzip mcl.zip && rm -f mcl.zip && chmod +x mcl
RUN wget -O plugins/mirai-api-http-v2.3.3.mirai.jar https://github.com/project-mirai/mirai-api-http/releases/download/v2.5.0/mirai-api-http-v2.5.0.mirai.jar
RUN ./mcl --update-package net.mamoe:chat-command --channel stable --type plugin
RUN echo exit | ./mcl && rm -fr config
ENTRYPOINT ["/app/mcl"]