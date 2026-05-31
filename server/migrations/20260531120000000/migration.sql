BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_config" (
    "id" bigserial PRIMARY KEY,
    "openRouterApiKey" text NOT NULL DEFAULT ''::text,
    "defaultModel" text NOT NULL DEFAULT 'google/gemini-2.5-flash-preview'::text,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT now()
);

--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260531120000000', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260531120000000', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713668', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713668', "timestamp" = now();


COMMIT;
