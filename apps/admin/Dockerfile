# base image
FROM node:16.3.0-alpine

# set working directory
WORKDIR /opt/code

# add `/usr/src/app/node_modules/.bin` and `/usr/local/bin` to $PATH
ENV PATH /usr/local/bin:/opt/code/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /opt/code/package.json
RUN apk --no-cache add --virtual builds-deps build-base && \
    npm install react-scripts@4.0.3 && \
    npm install && \
    apk del builds-deps

# start app
CMD ["npm", "run", "start"]
