# build nest api
FROM node:16.3.0-alpine AS build

WORKDIR /opt/code

COPY . /opt/code/

RUN npm install --only=development

RUN npm run build

# --------------------------------------------------------
FROM node:16.3.0-alpine AS production

# set working directory
WORKDIR /opt/code

# install and cache app dependencies
COPY . /opt/code/
COPY --from=build /opt/code/dist ./dist

# start app
CMD ["npm", "run", "start:prod"]
