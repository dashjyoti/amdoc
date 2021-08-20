
#base image nginx with tag alpine
FROM nginx:alpine
#maintainer data
MAINTAINER jyotiranjandash@gmail.com

# copy custom index file to nginx defalut 
COPY . /usr/share/nginx/html

#CMD["nginx", "-g", "daemon off;"]

