

FROM node:20 as build

WORKDIR /app
COPY package*.json ./
RUN npm ci
RUN npm install -g @angular/cli
COPY . .
RUN npm run build --configuration=production


# Stage 2: Serve Angular application
FROM nginx:1.25.4
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/app/browser /usr/share/nginx/html

