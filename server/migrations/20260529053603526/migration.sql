BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emergency_alert" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "triggeredBy" bigint NOT NULL,
    "alertType" text NOT NULL DEFAULT 'other'::text,
    "customMessage" text,
    "locationLat" double precision,
    "locationLng" double precision,
    "locationAddress" text,
    "batteryLevel" bigint,
    "triggerMethod" text NOT NULL DEFAULT 'panicButton'::text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "isTest" boolean NOT NULL DEFAULT false,
    "acknowledgedBy" bigint,
    "acknowledgedAt" timestamp without time zone,
    "resolvedBy" bigint,
    "resolvedAt" timestamp without time zone,
    "escalationLevel" bigint NOT NULL DEFAULT 1
);

-- Indexes
CREATE INDEX "emergency_alert_family_status_idx" ON "emergency_alert" USING btree ("familyId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emergency_contact" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "name" text NOT NULL,
    "phone" text NOT NULL,
    "email" text,
    "priority" bigint NOT NULL DEFAULT 1,
    "notes" text
);

-- Indexes
CREATE INDEX "emergency_contact_family_idx" ON "emergency_contact" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emergency_settings" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "panicButtonEnabled" boolean NOT NULL DEFAULT true,
    "requireConfirmation" boolean NOT NULL DEFAULT true,
    "confirmationSeconds" bigint NOT NULL DEFAULT 3,
    "escalationMinutesJson" text NOT NULL DEFAULT '[5,15,30]'::text
);

-- Indexes
CREATE UNIQUE INDEX "emergency_settings_family_idx" ON "emergency_settings" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "location_history" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "familyId" bigint NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "accuracyMeters" bigint,
    "address" text,
    "batteryLevel" bigint,
    "isManualCheckIn" boolean NOT NULL DEFAULT false,
    "recordedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "location_history_family_user_idx" ON "location_history" USING btree ("familyId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "location_sharing" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "familyId" bigint NOT NULL,
    "isEnabled" boolean NOT NULL DEFAULT false,
    "accuracyLevel" text NOT NULL DEFAULT 'precise'::text,
    "autoDisableAfterHours" bigint NOT NULL DEFAULT 24,
    "shareWithUserIdsJson" text NOT NULL DEFAULT '[]'::text,
    "enabledAt" timestamp without time zone,
    "expiresAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "location_sharing_user_family_idx" ON "location_sharing" USING btree ("userId", "familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "safe_zone" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "name" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "radiusMeters" bigint NOT NULL DEFAULT 100,
    "notifyOnEnter" boolean NOT NULL DEFAULT true,
    "notifyOnExit" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE INDEX "safe_zone_family_idx" ON "safe_zone" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_points" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "familyId" bigint NOT NULL,
    "points" bigint NOT NULL DEFAULT 0,
    "streakDays" bigint NOT NULL DEFAULT 0,
    "badgesJson" text NOT NULL DEFAULT '[]'::text
);

-- Indexes
CREATE UNIQUE INDEX "user_points_user_family_idx" ON "user_points" USING btree ("userId", "familyId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emergency_alert"
    ADD CONSTRAINT "emergency_alert_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emergency_contact"
    ADD CONSTRAINT "emergency_contact_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emergency_settings"
    ADD CONSTRAINT "emergency_settings_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "location_history"
    ADD CONSTRAINT "location_history_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "location_sharing"
    ADD CONSTRAINT "location_sharing_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "safe_zone"
    ADD CONSTRAINT "safe_zone_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_points"
    ADD CONSTRAINT "user_points_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260529053603526', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260529053603526', "timestamp" = now();

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
