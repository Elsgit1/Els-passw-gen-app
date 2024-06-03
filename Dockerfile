# Stage 1: Build environment
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app/build

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN apk add --no-cache nodejs npm && \
    npm install --only=production --ignore-scripts

# Copy the rest of the application source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Runtime environment
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the built application from the builder stage
COPY --from=builder /app/build .

# Expose port 80 for HTTP traffic
EXPOSE 80

# Containers run nginx with global directives and daemon off
CMD ["nginx", "-g", "daemon off;"]
