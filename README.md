# Jiushuyun Agent Service (Docker)

本项目用于将 **九数云 (Jiushuyun) 本地宝** 代理服务容器化。通过 GitHub Actions 实现每日定时构建，确保镜像环境的安全与更新，并自动推送到 GitHub Container Registry (GHCR)。

## 🚀 快速开始

### 1. 镜像地址
```bash
docker pull ghcr.io/awsl1110/jiushuyun-docker:latest
```

### 2. 使用 Docker Compose 部署

在服务器上创建目录并编写 `docker-compose.yml`：

```yaml
services:
  jiushuyun:
    image: ghcr.io/awsl1110/jiushuyun-docker:latest
    container_name: jiushuyun_app
    restart: always
    network_mode: "host"
    volumes:
      - /jiushuyun/config:/opt/jiushuyun/config  # 配置文件持久化
      - /jiushuyun/data:/mnt/data                # 数据目录
    deploy:
      resources:
        limits:
          memory: 2G
```

---

## 📂 目录结构
/opt/jiushuyun该目录为九数云本地宝服务的安装根目录，包含了程序运行的核心二进制文件、依赖库及环境配置。
