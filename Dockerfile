FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN cd /opt && yarn && cd - && yarn build
