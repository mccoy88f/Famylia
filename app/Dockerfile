# Build Flutter Web — contesto build: root monorepo (vedi docker-compose)
# SERVER_URL viene derivato automaticamente da Uri.base a runtime (stesso host, porta 8080)
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /src
COPY client ./client

WORKDIR /src/app
COPY app/pubspec.yaml app/pubspec.lock ./
RUN flutter pub get

COPY app ./
RUN flutter build web --release

FROM nginx:alpine
COPY docker/nginx/app.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/app/build/web /usr/share/nginx/html
EXPOSE 80
