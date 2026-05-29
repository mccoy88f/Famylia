BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shopping_item" (
    "id" bigserial PRIMARY KEY,
    "shoppingListId" bigint NOT NULL,
    "name" text NOT NULL,
    "quantity" double precision NOT NULL DEFAULT 1,
    "unit" text NOT NULL DEFAULT 'pieces'::text,
    "category" text NOT NULL DEFAULT 'other'::text,
    "isChecked" boolean NOT NULL DEFAULT false,
    "checkedBy" bigint,
    "checkedAt" timestamp without time zone,
    "priceEstimate" double precision,
    "notes" text,
    "addedBy" bigint NOT NULL,
    "isUrgent" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "shopping_item_list_idx" ON "shopping_item" USING btree ("shoppingListId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shopping_list" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "name" text NOT NULL,
    "store" text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "assignedTo" bigint,
    "dueDate" timestamp without time zone
);

-- Indexes
CREATE INDEX "shopping_list_family_status_idx" ON "shopping_list" USING btree ("familyId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo_item" (
    "id" bigserial PRIMARY KEY,
    "familyId" bigint NOT NULL,
    "createdBy" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "category" text NOT NULL DEFAULT 'other'::text,
    "priority" text NOT NULL DEFAULT 'medium'::text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "assignedTo" bigint,
    "dueDate" timestamp without time zone,
    "points" bigint NOT NULL DEFAULT 10,
    "completedAt" timestamp without time zone,
    "completedBy" bigint
);

-- Indexes
CREATE INDEX "todo_item_family_status_idx" ON "todo_item" USING btree ("familyId", "status");
CREATE INDEX "todo_item_family_assigned_idx" ON "todo_item" USING btree ("familyId", "assignedTo");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shopping_item"
    ADD CONSTRAINT "shopping_item_fk_0"
    FOREIGN KEY("shoppingListId")
    REFERENCES "shopping_list"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shopping_list"
    ADD CONSTRAINT "shopping_list_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "todo_item"
    ADD CONSTRAINT "todo_item_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR famylia
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('famylia', '20260528210057383', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528210057383', "timestamp" = now();

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
