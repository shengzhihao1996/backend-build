FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN cd /yarn && ls && yarn && cd - && yarn build
