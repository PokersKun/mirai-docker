FROM adoptopenjdk/openjdk11-openj9:alpine-jre
EXPOSE 8080
WORKDIR /app
RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache procps unzip curl bash tzdata \
	&& apk add ffmpeg \
    && apk add libavcodec-extra \
	&& apk add python3 \
    && ln -s /usr/bin/python3 /usr/bin/python
RUN wget -O mcl.zip https://github.com/iTXTech/mirai-console-loader/releases/download/v2.1.0/mcl-2.1.0.zip && unzip mcl.zip && rm -f mcl.zip && chmod +x mcl
RUN ./mcl --update-package net.mamoe:chat-command --channel stable --type plugin
RUN echo exit | ./mcl && rm -fr config
ENTRYPOINT ["/app/mcl"]