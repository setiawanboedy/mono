FROM postgres:13-alpine

# Copy all files into the db start folder (the db is just started at the image boot)
COPY ./init/* /docker-entrypoint-initdb.d/
