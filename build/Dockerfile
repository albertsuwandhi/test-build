FROM node:14

ENV SERVER_DIR /opt/ir-notification-backend

RUN mkdir -p $SERVER_DIR

WORKDIR $SERVER_DIR

# COPY ./dist/package.json ./
# RUN npm install
CMD ls -al
COPY ./dist ./
CMD node app.js
