# Build Stage
FROM node:14-alpine as build-step

# Set working directory
WORKDIR /app

# Copy package.json
COPY package.json /app/

# Install dependencies
RUN npm install

# Copy remaining files
COPY . /app

# Build app
RUN npm run build

# Nginx Stage
FROM nginx:1.17.1-alpine

# Working directory
WORKDIR /usr/share/nginx/html

# Copy build files
COPY --from=build-step /app/build ./

# Run Default Command
CMD ["nginx", "-g", "daemon off;"]