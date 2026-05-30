BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "family" ADD COLUMN "accentColor" text DEFAULT '#5B8DEF'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "meal_plan" ADD COLUMN "linkedHealthEntryId" bigint;

--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260530165034996', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260530165034996', "timestamp" = now();

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
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
