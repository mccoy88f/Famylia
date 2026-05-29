BEGIN;

--
-- Class BoardPost as table board_post
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
-- Class CalendarEvent as table calendar_event
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
-- Class Deadline as table deadline
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
-- Class DocumentRecord as table document_record
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
-- Class Expense as table expense
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
-- Class Family as table family
--
CREATE TABLE "family" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "inviteCode" text NOT NULL,
    "settings" text DEFAULT '{}'::text
);

-- Indexes
CREATE UNIQUE INDEX "family_invite_code_idx" ON "family" USING btree ("inviteCode");

--
-- Class FamilyMember as table family_member
--
CREATE TABLE "family_member" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "familyId" bigint NOT NULL,
    "role" text NOT NULL DEFAULT 'member'::text
);

-- Indexes
CREATE UNIQUE INDEX "family_member_user_family_idx" ON "family_member" USING btree ("userId", "familyId");

--
-- Class MealPlan as table meal_plan
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
-- Class PollOption as table poll_option
--
CREATE TABLE "poll_option" (
    "id" bigserial PRIMARY KEY,
    "boardPostId" bigint NOT NULL,
    "text" text NOT NULL,
    "votesJson" text NOT NULL DEFAULT '[]'::text
);

--
-- Class Recipe as table recipe
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
-- Class Settlement as table settlement
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
-- Class ShoppingItem as table shopping_item
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
-- Class ShoppingList as table shopping_list
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
-- Class TodoItem as table todo_item
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
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "board_post" table
--
ALTER TABLE ONLY "board_post"
    ADD CONSTRAINT "board_post_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "calendar_event" table
--
ALTER TABLE ONLY "calendar_event"
    ADD CONSTRAINT "calendar_event_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "deadline" table
--
ALTER TABLE ONLY "deadline"
    ADD CONSTRAINT "deadline_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "document_record" table
--
ALTER TABLE ONLY "document_record"
    ADD CONSTRAINT "document_record_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "expense" table
--
ALTER TABLE ONLY "expense"
    ADD CONSTRAINT "expense_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "family_member" table
--
ALTER TABLE ONLY "family_member"
    ADD CONSTRAINT "family_member_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "meal_plan" table
--
ALTER TABLE ONLY "meal_plan"
    ADD CONSTRAINT "meal_plan_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "poll_option" table
--
ALTER TABLE ONLY "poll_option"
    ADD CONSTRAINT "poll_option_fk_0"
    FOREIGN KEY("boardPostId")
    REFERENCES "board_post"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "recipe" table
--
ALTER TABLE ONLY "recipe"
    ADD CONSTRAINT "recipe_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "settlement" table
--
ALTER TABLE ONLY "settlement"
    ADD CONSTRAINT "settlement_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "shopping_item" table
--
ALTER TABLE ONLY "shopping_item"
    ADD CONSTRAINT "shopping_item_fk_0"
    FOREIGN KEY("shoppingListId")
    REFERENCES "shopping_list"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "shopping_list" table
--
ALTER TABLE ONLY "shopping_list"
    ADD CONSTRAINT "shopping_list_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "todo_item" table
--
ALTER TABLE ONLY "todo_item"
    ADD CONSTRAINT "todo_item_fk_0"
    FOREIGN KEY("familyId")
    REFERENCES "family"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
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
