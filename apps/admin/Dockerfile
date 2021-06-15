# base image
FROM node:16.3.0-alpine

# set working directory
WORKDIR /opt/code

# install and cache app dependencies
COPY . /opt/code/

RUN apk --no-cache add --virtual builds-deps build-base && \
    npm install react-scripts@4.0.3 && \
    npm install && \
    apk del builds-deps

# start app
CMD ["npm", "run", "start"]
