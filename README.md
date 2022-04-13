# Dockerfile for mirai v2

[Mirai](https://github.com/mamoe/mirai) 定制化环境的 Dockerfile，包含的组件如下：

* chat-command
* mirai-http-api
* Python 3
* ffmpeg

使用了 [Eclipse OpenJ9 JVM](https://www.eclipse.org/openj9/) 以减少内存占用。

## 运行方法

### 目录准备

Mirai 将登录信息的配置文件保存在 `bots` 与 `config` 文件夹中。

在镜像中，这两个文件夹分别位于 `/app/bots` 与 `/app/config` 中。

建议将这些信息保存到容器外部。

新建文件夹：

```bash
mkdir mirai
mkdir mirai/bots
mkdir mirai/config
mkdir mirai/data
mkdir mirai/plugins
mkdir mirai/extras
```

### 使用 Docker 运行

在刚刚建立的 `mirai` 目录中，运行：

```bash
docker run \
    --name mirai \
    -v "$PWD"/bots:/app/bots \
    -v "$PWD"/config:/app/config \
    -v "$PWD"/data:/app/data \
    -v "$PWD"/plugins:/app/plugins \
    -v "$PWD"/extras:/app/extras \
    -it \
    pocketfan233/mirai
```

### 使用 Docker Compose 运行

将以下内容保存到 `mirai/docker-compose.yml` 文件中：

```yml
version: "1"

services:
  mirai:
    image: pocketfan233/mirai
    container_name: mirai
    stdin_open: true
    tty: true
    volumes:
      - ./bots:/app/bots
      - ./config:/app/config
      - ./data:/app/data
      - ./plugins:/app/plugins
      - ./extras:/app/extras
```

随后使用 `docker-compose up -d` 运行。


## 容器相关的操作

连按 `Ctrl-P` `Ctrl-Q`，将容器转为后台运行。可通过 `docker logs mirai` 查看输出，或使用 `docker attach mirai` 再次连接容器。
