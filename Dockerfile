FROM registry.cn-beijing.aliyuncs.com/comall/backend:base as builder

FROM python:3.6

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" >/etc/apt/sources.list && \
 echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >>/etc/apt/sources.list && \
 echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >>/etc/apt/sources.list && \
 echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >>/etc/apt/sources.list

# init
RUN apt-get update && \
    apt-get install -y nginx git && \
    mkdir /run/nginx/

#  front file
COPY --from=builder /store/static.tar.gz /app/html/

# python file
COPY --from=builder /store/python.tar.gz  /app/pipeline/ 

# nginx file
COPY --from=builder /store/pipeline-distribution-tool.conf /etc/nginx/conf.d/

# start script
COPY --from=builder /store/entrypoint.sh /

RUN cd /app/html/ && tar xf static.tar.gz && rm -f static.tar.gz && \
    cd /app/pipeline && tar xf python.tar.gz && rm -f python.tar.gz 
    
RUN cd /app/pipeline/ && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt && \
    chmod +x /entrypoint.sh
    
WORKDIR /app

CMD ["/entrypoint.sh"]
