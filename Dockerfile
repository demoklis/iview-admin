FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
# -g cnpm --registry=https://registry.npm.taobao.org
#RUN npm install
COPY . .
RUN npm run build:dev

# production stage
FROM nginx:stable-alpine as production-stage
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /app/dist/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
