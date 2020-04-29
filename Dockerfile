FROM registry.cn-beijing.aliyuncs.com/comall/backend:base as builder

FROM python:3.6
#  front file
ADD --from=builder /store/static.tar.gz /app/html/

# python file
ADD --from=builder /store/python.tar.gz  /app/pipeline/ 

# nginx file
COPY --from=builder /store/pipeline-distribution-tool.conf /etc/nginx/conf.d/

# start script
COPY --from=builder /store/entrypoint.sh /

RUN apt-get update && \
    apt-get install -y nginx git && \
    mkdir /run/nginx/ && \
    cd /app/pipeline/ && \
    pip3 install -r requirements.txt && \
    RUN chmod +x /entrypoint.sh
    
WORKDIR /app

CMD ["/entrypoint.sh"]
