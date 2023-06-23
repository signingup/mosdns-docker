FROM alpine

RUN apk update && apk add ca-certificates openrc unzip curl bash && \
    mkdir -p /home/mosdns && \
    wget -O /home/mosdns/main.zip https://github.com/signingup/easymosdns/archive/refs/heads/main.zip && \
    wget -O /home/mosdns/mosdns.zip https://github.com/IrineSistiana/mosdns/releases/download/v4.5.3/mosdns-linux-amd64.zip && \
    cd /home/mosdns/ && \
    unzip mosdns.zip && \
    mv mosdns /usr/bin && \
    unzip  main.zip && \
    mv easymosdns-main /etc/mosdns && \
    cd / && rm -rf /home/mosdns && \
    cp /etc/mosdns/rules/update* /root && \
    echo "0 5 * * * /root/update-cdn" >> /etc/crontabs/root
ADD ./entrypoint.sh entrypoint.sh
ENV TZ=Asia/Shanghai
EXPOSE 5353
ENTRYPOINT ["sh", "./entrypoint.sh"]
