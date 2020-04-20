FROM node:10

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY . /usr/src/app

RUN npm install
RUN npm install semver
RUN npm install -g npm-cli-login 
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .
CMD [ "npm", "start" ]
