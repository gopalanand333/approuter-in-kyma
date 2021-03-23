FROM node:10-slim

# Execute docker build from top-level project directory

WORKDIR /usr/src/app
COPY . .
RUN npm install

EXPOSE 5000
CMD [ "npm", "start" ]