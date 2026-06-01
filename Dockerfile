# Stage 1: Build Vue app
FROM node:18-alpine as build-stage

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy semua source code
COPY . .

# Build aplikasi Vue
RUN npm run build

# Stage 2: Production dengan Nginx
FROM nginx:stable-alpine as production-stage

# Copy hasil build dari stage 1 ke nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copy custom nginx config (opsional)
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
