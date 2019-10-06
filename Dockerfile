FROM v2ray/official:latest
WORKDIR /home/NoOne-hub/v2ray/
COPY entrypoint.sh v2ray_client/ ./
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
 && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community" >> /etc/apk/repositories
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        && chmod +x entrypoint.sh

RUN apk add --no-cache python3
RUN mkdir ~/.pip
RUN echo "[global]" >> ~/.pip/pip.conf \
        && echo "index-url =  http://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf \
        && echo "trusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf

RUN pip3 install -r ./requirements.txt --no-cache
ENTRYPOINT ["./entrypoint.sh"]








