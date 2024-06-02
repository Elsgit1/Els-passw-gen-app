# Stage 1: Build the application
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# Build step (if your app requires a build process) # Adjust build command if needed
RUN npm run build  

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Set the working directory to Nginx's serve directory
WORKDIR /usr/share/nginx/html

# Copy only production files from the builder stage
COPY --from=builder /app/build .

# Expose port 80 for HTTP traffic
EXPOSE 80

# Containers run nginx with global directives and daemon off
CMD ["nginx", "-g", "daemon off;"]
