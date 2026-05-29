BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "board_post" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text,
    "content" text NOT NULL,
    "type" text NOT NULL DEFAULT 'note'::text,
    "isPinned" boolean NOT NULL DEFAULT false,
    "expiresAt" timestamp without time zone,
    "reactionsJson" text NOT NULL DEFAULT '{}'::text,
    "commentsJson" text NOT NULL DEFAULT '[]'::text
);

-- Indexes
CREATE INDEX "board_post_family_idx" ON "board_post" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calendar_event" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "category" text NOT NULL DEFAULT 'other'::text,
    "startAt" timestamp without time zone NOT NULL,
    "endAt" timestamp without time zone,
    "isAllDay" boolean NOT NULL DEFAULT false,
    "location" text,
    "assignedTo" bigint,
    "isPrivate" boolean NOT NULL DEFAULT false,
    "color" text,
    "reminderMinutesJson" text
);

-- Indexes
CREATE INDEX "calendar_event_family_start_idx" ON "calendar_event" USING btree ("familyId", "startAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "deadline" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "category" text NOT NULL DEFAULT 'other'::text,
    "amount" double precision,
    "currency" text NOT NULL DEFAULT 'EUR'::text,
    "dueDate" timestamp without time zone NOT NULL,
    "isRecurring" boolean NOT NULL DEFAULT false,
    "recurrenceRule" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "priority" text NOT NULL DEFAULT 'medium'::text,
    "assignedTo" bigint,
    "notifyBeforeHoursJson" text DEFAULT '[24,72]'::text,
    "isPrivate" boolean NOT NULL DEFAULT false,
    "completedAt" timestamp without time zone,
    "completedBy" bigint
);

-- Indexes
CREATE INDEX "deadline_family_due_idx" ON "deadline" USING btree ("familyId", "dueDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "document_record" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "uploadedBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "fileUrl" text NOT NULL,
    "fileType" text NOT NULL DEFAULT 'other'::text,
    "fileSizeBytes" bigint,
    "category" text NOT NULL DEFAULT 'other'::text,
    "relatedDeadlineId" bigint,
    "relatedExpenseId" bigint,
    "ocrDataJson" text,
    "accessLevel" text NOT NULL DEFAULT 'family'::text
);

-- Indexes
CREATE INDEX "document_record_family_idx" ON "document_record" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "expense" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "amount" double precision NOT NULL,
    "currency" text NOT NULL DEFAULT 'EUR'::text,
    "category" text NOT NULL DEFAULT 'other'::text,
    "paidBy" bigint NOT NULL,
    "splitType" text NOT NULL DEFAULT 'equal'::text,
    "splitDetailsJson" text NOT NULL DEFAULT '[]'::text,
    "expenseDate" timestamp without time zone NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text
);

-- Indexes
CREATE INDEX "expense_family_date_idx" ON "expense" USING btree ("familyId", "expenseDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meal_plan" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "weekStart" timestamp without time zone NOT NULL,
    "mealsJson" text NOT NULL DEFAULT '[]'::text
);

-- Indexes
CREATE INDEX "meal_plan_family_week_idx" ON "meal_plan" USING btree ("familyId", "weekStart");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "poll_option" (
    "id" bigserial PRIMARY KEY,
    "boardPostId" bigint NOT NULL,
    "text" text NOT NULL,
    "votesJson" text NOT NULL DEFAULT '[]'::text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "recipe" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "ingredientsJson" text NOT NULL DEFAULT '[]'::text,
    "servings" bigint NOT NULL DEFAULT 4
);

-- Indexes
CREATE INDEX "recipe_family_idx" ON "recipe" USING btree ("familyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "settlement" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "fromUserId" bigint NOT NULL,
    "toUserId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "currency" text NOT NULL DEFAULT 'EUR'::text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "settledAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "settlement_family_idx" ON "settlement" USING btree ("familyId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "board_post"
    ADD CONSTRAINT "board_post_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "calendar_event"
    ADD CONSTRAINT "calendar_event_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "deadline"
    ADD CONSTRAINT "deadline_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "document_record"
    ADD CONSTRAINT "document_record_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "expense"
    ADD CONSTRAINT "expense_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meal_plan"
    ADD CONSTRAINT "meal_plan_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "poll_option"
    ADD CONSTRAINT "poll_option_fk_0"
    FOREIGN KEY("boardPostId")
    REFERENCES "board_post"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "recipe"
    ADD CONSTRAINT "recipe_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "settlement"
    ADD CONSTRAINT "settlement_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260528214000986', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528214000986', "timestamp" = now();

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
