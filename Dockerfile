FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN apt-get update && \
    apt-get install -y nginx git && \
    mkdir /run/nginx/
RUN cd /app/pipeline/ && \
    pip3 install -r requirements.txt
