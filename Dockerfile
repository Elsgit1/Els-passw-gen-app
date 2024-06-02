FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY . .
RUN npm install --production
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]