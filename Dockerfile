FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y \
    locales \
    procps \
    libnss3 \
    fontconfig \
    ca-certificates \
    wget \
    && locale-gen en_US.UTF-8 \
    && wget -q -O /tmp/install.sh "https://qfx-market.oss-cn-hangzhou.aliyuncs.com/agent/unix_%E6%9C%AC%E5%9C%B0%E5%AE%9D_3_0_0.sh" \
    && chmod +x /tmp/install.sh \
    && (printf "\n/opt/jiushuyun\n\n\nn\nn\nn\n" | /tmp/install.sh || true) \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/jiushuyun
ENV PATH="/opt/jiushuyun/jre/bin:${PATH}"
CMD ["/bin/bash", "-c", "./agent-service start && sleep 5 && tail -f /dev/null"]