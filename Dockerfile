FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /tmp

# 2. 安装基础依赖（包含语言包支持）
RUN apt-get update && apt-get install -y \
    locales \
    procps \
    libnss3 \
    fontconfig \
    ca-certificates \
    wget \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. 下载并自动安装
RUN wget -O install.sh "https://qfx-market.oss-cn-hangzhou.aliyuncs.com/agent/unix_%E6%9C%AC%E5%9C%B0%E5%AE%9D_3_0_0.sh" && \
    chmod +x install.sh && \
    # 自动回答逻辑说明 \
    # 1. \n (回车): 确定安装
    # 2. /opt/jiushuyun\n : 安装路径
    # 3. \n (回车): 确认创建快捷连接 (默认是)
    # 4. \n (回车): 快捷连接路径 (默认 /usr/local/bin)
    # 5. n\n : 在安装目录打开 (选 否)
    # 6. n\n : 启动服务 (选 否，因为 Docker 构建阶段不能启动后台服务)
    # 7. n\n : 开机自启 (选 否，Docker 容器不适用此项)
    printf "\n/opt/jiushuyun\n\n\nn\nn\nn\n" | ./install.sh && \
    rm install.sh

# 4. 配置运行环境
WORKDIR /opt/jiushuyun
ENV PATH="/opt/jiushuyun/jre/bin:${PATH}"

# 5. 启动命令
CMD ["/bin/bash", "-c", "./agent-service start && sleep 5 && tail -f /dev/null"]