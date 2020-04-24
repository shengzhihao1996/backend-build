FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN cd /yarn && yarn && cd - && yarn build
