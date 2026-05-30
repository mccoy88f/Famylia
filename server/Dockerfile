FROM dart:3.8-sdk AS build
WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN dart pub get

COPY lib lib
COPY bin bin
COPY config config
COPY migrations migrations
RUN cp config/passwords.docker.yaml config/passwords.yaml
RUN dart pub get

FROM dart:3.8-sdk
WORKDIR /app
COPY --from=build /app /app
RUN dart pub get

EXPOSE 8080 8081 8082

ENV runmode=development
ENV role=monolith
ENV logging=normal
ENV SERVERPOD_DATABASE_HOST=postgres
ENV SERVERPOD_DATABASE_PORT=5432
ENV SERVERPOD_REDIS_HOST=redis
ENV SERVERPOD_REDIS_PORT=6379
ENV SERVERPOD_REDIS_ENABLED=true

CMD ["dart", "run", "bin/main.dart", "--apply-migrations"]
