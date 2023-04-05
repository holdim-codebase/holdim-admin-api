# MAIN IMAGE
FROM node:16-alpine

# Install OpenSSL
RUN apk add --update libc6-compat openssl openssl-dev openssl1.1-compat

# Add working directory in the docker container
WORKDIR /usr/src/app

# Add package file
COPY package.json ./
COPY yarn.lock ./

# Install deps
RUN yarn

# Copy source
COPY . .

# Build dist
RUN yarn build

# Run dist
CMD yarn start
