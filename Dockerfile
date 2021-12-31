FROM adoptopenjdk/openjdk11-openj9:alpine-jre
WORKDIR /app
RUN wget -O mcl.zip https://github.com/iTXTech/mirai-console-loader/releases/download/v1.2.2/mcl-1.2.2.zip && unzip mcl.zip && rm -f mcl.zip && chmod +x mcl
RUN wget -O plugins/chat-command-0.5.1.jar https://github.com/project-mirai/chat-command/releases/download/0.5.1/chat-command-0.5.1.jar
RUN echo exit | ./mcl && rm -fr config
ENTRYPOINT ["/app/mcl"]
