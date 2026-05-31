# Build Flutter Web — contesto build: root monorepo (vedi docker-compose)
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /src
COPY client ./client

WORKDIR /src/app
COPY app/pubspec.yaml app/pubspec.lock ./
RUN flutter pub get

COPY app ./
RUN flutter build web --release \
    --dart-define=SERVER_URL=http://localhost:8080/

FROM nginx:alpine
COPY docker/nginx/app.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/app/build/web /usr/share/nginx/html
EXPOSE 80
