# build
FROM node:8.11.3-alpine AS build
WORKDIR /app
ADD . /app
RUN yarn config set registry https://registry.npm.taobao.org && yarn && yarn run build

# run
FROM node:8.11.3-alpine 
RUN yarn config set registry https://registry.npm.taobao.org && yarn global add serve
WORKDIR /app
COPY --from=build /app/build /app
CMD ["serve", "-s", "./", "-p", "3000"]
EXPOSE 3000