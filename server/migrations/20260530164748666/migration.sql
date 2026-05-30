BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "health_entry" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "status" text NOT NULL DEFAULT 'planned'::text,
    "assignedTo" bigint,
    "scheduledAt" timestamp without time zone,
    "endAt" timestamp without time zone,
    "providerName" text,
    "location" text,
    "dietGoal" text,
    "caloriesTarget" bigint,
    "sportType" text,
    "durationMinutes" bigint,
    "intensity" text,
    "isPrivate" boolean NOT NULL DEFAULT false,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "health_entry_family_type_idx" ON "health_entry" USING btree ("familyId", "type");
CREATE INDEX "health_entry_family_scheduled_idx" ON "health_entry" USING btree ("familyId", "scheduledAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "health_entry"
    ADD CONSTRAINT "health_entry_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260530164748666', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260530164748666', "timestamp" = now();

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
