FROM registry.cn-beijing.aliyuncs.com/comall/backend:build
RUN cd /opt && yarn && cd - && yarn build
