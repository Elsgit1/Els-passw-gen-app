# Use an official Nginx image as the base image
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy package.json and lock file (if exists)
COPY package*.json ./

# Install only production dependencies
RUN apk add --no-cache nodejs npm && \
    npm install --only=production --ignore-scripts

# Copy the application source code to Nginx's default public directory
COPY . .

# Expose port 80 for HTTP traffic
EXPOSE 80

# Containers run nginx with global directives and daemon off
CMD ["nginx", "-g", "daemon off;"]
