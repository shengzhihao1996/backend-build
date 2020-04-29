FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN cd /app/pipeline/ && \
    pip3 install -r requirements.txt
