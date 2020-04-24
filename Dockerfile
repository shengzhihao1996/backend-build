FROM registry.cn-beijing.aliyuncs.com/comall/backend:base
RUN cd /yarn && rm -f yarn.lock  && yarn && cd - && yarn build
