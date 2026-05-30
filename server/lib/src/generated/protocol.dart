/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'board_changed.dart' as _i4;
import 'board_post.dart' as _i5;
import 'board_post_type.dart' as _i6;
import 'board_post_with_poll.dart' as _i7;
import 'calendar_event.dart' as _i8;
import 'calendar_event_category.dart' as _i9;
import 'deadline.dart' as _i10;
import 'deadline_category.dart' as _i11;
import 'deadline_priority.dart' as _i12;
import 'deadline_status.dart' as _i13;
import 'document_access_level.dart' as _i14;
import 'document_category.dart' as _i15;
import 'document_file_type.dart' as _i16;
import 'document_record.dart' as _i17;
import 'emergency_alert.dart' as _i18;
import 'emergency_alert_status.dart' as _i19;
import 'emergency_alert_type.dart' as _i20;
import 'emergency_changed.dart' as _i21;
import 'emergency_contact.dart' as _i22;
import 'emergency_settings.dart' as _i23;
import 'emergency_trigger_method.dart' as _i24;
import 'expense.dart' as _i25;
import 'expense_category.dart' as _i26;
import 'expense_split_type.dart' as _i27;
import 'expense_status.dart' as _i28;
import 'family.dart' as _i29;
import 'family_balance.dart' as _i30;
import 'family_member.dart' as _i31;
import 'family_member_info.dart' as _i32;
import 'family_report.dart' as _i33;
import 'family_role.dart' as _i34;
import 'family_with_role.dart' as _i35;
import 'famylia_exception.dart' as _i36;
import 'gdpr_export.dart' as _i37;
import 'health_entry.dart' as _i38;
import 'health_entry_status.dart' as _i39;
import 'health_entry_type.dart' as _i40;
import 'leaderboard.dart' as _i41;
import 'leaderboard_entry.dart' as _i42;
import 'location_accuracy_level.dart' as _i43;
import 'location_history.dart' as _i44;
import 'location_sharing.dart' as _i45;
import 'meal_plan.dart' as _i46;
import 'member_balance.dart' as _i47;
import 'member_location.dart' as _i48;
import 'poll_option.dart' as _i49;
import 'privacy_dashboard.dart' as _i50;
import 'recipe.dart' as _i51;
import 'safe_zone.dart' as _i52;
import 'settlement.dart' as _i53;
import 'settlement_status.dart' as _i54;
import 'settlement_suggestion.dart' as _i55;
import 'shopping_category.dart' as _i56;
import 'shopping_item.dart' as _i57;
import 'shopping_list.dart' as _i58;
import 'shopping_list_changed.dart' as _i59;
import 'shopping_list_status.dart' as _i60;
import 'shopping_list_with_items.dart' as _i61;
import 'shopping_unit.dart' as _i62;
import 'sport_intensity.dart' as _i63;
import 'todo_category.dart' as _i64;
import 'todo_item.dart' as _i65;
import 'todo_priority.dart' as _i66;
import 'todo_status.dart' as _i67;
import 'user_points.dart' as _i68;
import 'package:famylia_server/src/generated/board_post_with_poll.dart' as _i69;
import 'package:famylia_server/src/generated/calendar_event.dart' as _i70;
import 'package:famylia_server/src/generated/deadline.dart' as _i71;
import 'package:famylia_server/src/generated/document_record.dart' as _i72;
import 'package:famylia_server/src/generated/emergency_alert.dart' as _i73;
import 'package:famylia_server/src/generated/emergency_contact.dart' as _i74;
import 'package:famylia_server/src/generated/expense.dart' as _i75;
import 'package:famylia_server/src/generated/settlement.dart' as _i76;
import 'package:famylia_server/src/generated/family_with_role.dart' as _i77;
import 'package:famylia_server/src/generated/family_member_info.dart' as _i78;
import 'package:famylia_server/src/generated/health_entry.dart' as _i79;
import 'package:famylia_server/src/generated/member_location.dart' as _i80;
import 'package:famylia_server/src/generated/safe_zone.dart' as _i81;
import 'package:famylia_server/src/generated/recipe.dart' as _i82;
import 'package:famylia_server/src/generated/shopping_list.dart' as _i83;
import 'package:famylia_server/src/generated/todo_item.dart' as _i84;
export 'board_changed.dart';
export 'board_post.dart';
export 'board_post_type.dart';
export 'board_post_with_poll.dart';
export 'calendar_event.dart';
export 'calendar_event_category.dart';
export 'deadline.dart';
export 'deadline_category.dart';
export 'deadline_priority.dart';
export 'deadline_status.dart';
export 'document_access_level.dart';
export 'document_category.dart';
export 'document_file_type.dart';
export 'document_record.dart';
export 'emergency_alert.dart';
export 'emergency_alert_status.dart';
export 'emergency_alert_type.dart';
export 'emergency_changed.dart';
export 'emergency_contact.dart';
export 'emergency_settings.dart';
export 'emergency_trigger_method.dart';
export 'expense.dart';
export 'expense_category.dart';
export 'expense_split_type.dart';
export 'expense_status.dart';
export 'family.dart';
export 'family_balance.dart';
export 'family_member.dart';
export 'family_member_info.dart';
export 'family_report.dart';
export 'family_role.dart';
export 'family_with_role.dart';
export 'famylia_exception.dart';
export 'gdpr_export.dart';
export 'health_entry.dart';
export 'health_entry_status.dart';
export 'health_entry_type.dart';
export 'leaderboard.dart';
export 'leaderboard_entry.dart';
export 'location_accuracy_level.dart';
export 'location_history.dart';
export 'location_sharing.dart';
export 'meal_plan.dart';
export 'member_balance.dart';
export 'member_location.dart';
export 'poll_option.dart';
export 'privacy_dashboard.dart';
export 'recipe.dart';
export 'safe_zone.dart';
export 'settlement.dart';
export 'settlement_status.dart';
export 'settlement_suggestion.dart';
export 'shopping_category.dart';
export 'shopping_item.dart';
export 'shopping_list.dart';
export 'shopping_list_changed.dart';
export 'shopping_list_status.dart';
export 'shopping_list_with_items.dart';
export 'shopping_unit.dart';
export 'sport_intensity.dart';
export 'todo_category.dart';
export 'todo_item.dart';
export 'todo_priority.dart';
export 'todo_status.dart';
export 'user_points.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'board_post',
      dartName: 'BoardPost',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'board_post_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BoardPostType',
          columnDefault: '\'note\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isPinned',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'reactionsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'{}\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'commentsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'board_post_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'board_post_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'board_post_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'calendar_event',
      dartName: 'CalendarEvent',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'calendar_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CalendarEventCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'startAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isAllDay',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'assignedTo',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isPrivate',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reminderMinutesJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'calendar_event_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'calendar_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'calendar_event_family_start_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'deadline',
      dartName: 'Deadline',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'deadline_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeadlineCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'EUR\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'dueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isRecurring',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'recurrenceRule',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeadlineStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeadlinePriority',
          columnDefault: '\'medium\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignedTo',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'notifyBeforeHoursJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'[24,72]\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isPrivate',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'deadline_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'deadline_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'deadline_family_due_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'dueDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'document_record',
      dartName: 'DocumentRecord',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'document_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'uploadedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocumentFileType',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'fileSizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocumentCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'relatedDeadlineId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedExpenseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'ocrDataJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'accessLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocumentAccessLevel',
          columnDefault: '\'family\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'document_record_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'document_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'document_record_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'emergency_alert',
      dartName: 'EmergencyAlert',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'emergency_alert_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'triggeredBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'alertType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EmergencyAlertType',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'customMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'locationLat',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'locationLng',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'locationAddress',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'batteryLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'triggerMethod',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EmergencyTriggerMethod',
          columnDefault: '\'panicButton\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EmergencyAlertStatus',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isTest',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'escalationLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'emergency_alert_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'emergency_alert_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'emergency_alert_family_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'emergency_contact',
      dartName: 'EmergencyContact',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'emergency_contact_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'emergency_contact_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'emergency_contact_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'emergency_contact_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'emergency_settings',
      dartName: 'EmergencySettings',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'emergency_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'panicButtonEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'requireConfirmation',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'confirmationSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '3',
        ),
        _i2.ColumnDefinition(
          name: 'escalationMinutesJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[5,15,30]\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'emergency_settings_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'emergency_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'emergency_settings_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'expense',
      dartName: 'Expense',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'expense_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'EUR\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExpenseCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'paidBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'splitType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExpenseSplitType',
          columnDefault: '\'equal\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'splitDetailsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'expenseDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ExpenseStatus',
          columnDefault: '\'active\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'expense_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'expense_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'expense_family_date_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'expenseDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'family',
      dartName: 'Family',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'family_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'inviteCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'accentColor',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'#5B8DEF\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'settings',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
          columnDefault: '\'{}\'::text',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'family_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'family_invite_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'family_member',
      dartName: 'FamilyMember',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'family_member_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FamilyRole',
          columnDefault: '\'member\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'family_member_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'family_member_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'family_member_user_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'health_entry',
      dartName: 'HealthEntry',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'health_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:HealthEntryType',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:HealthEntryStatus',
          columnDefault: '\'planned\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignedTo',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'endAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'providerName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dietGoal',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'caloriesTarget',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sportType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'durationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'intensity',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SportIntensity?',
        ),
        _i2.ColumnDefinition(
          name: 'isPrivate',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'health_entry_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'health_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'health_entry_family_type_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'health_entry_family_scheduled_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scheduledAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'location_history',
      dartName: 'LocationHistory',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'location_history_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'accuracyMeters',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'batteryLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isManualCheckIn',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'recordedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'location_history_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'location_history_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'location_history_family_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'location_sharing',
      dartName: 'LocationSharing',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'location_sharing_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'accuracyLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LocationAccuracyLevel',
          columnDefault: '\'precise\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'autoDisableAfterHours',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '24',
        ),
        _i2.ColumnDefinition(
          name: 'shareWithUserIdsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'enabledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'location_sharing_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'location_sharing_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'location_sharing_user_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'meal_plan',
      dartName: 'MealPlan',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'meal_plan_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'weekStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'mealsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'linkedHealthEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'meal_plan_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'meal_plan_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'meal_plan_family_week_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'weekStart',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'poll_option',
      dartName: 'PollOption',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'poll_option_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'boardPostId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'votesJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'poll_option_fk_0',
          columns: ['boardPostId'],
          referenceTable: 'board_post',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'poll_option_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'recipe',
      dartName: 'Recipe',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'recipe_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ingredientsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'servings',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '4',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'recipe_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'recipe_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'recipe_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'safe_zone',
      dartName: 'SafeZone',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'safe_zone_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'latitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'longitude',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'radiusMeters',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '100',
        ),
        _i2.ColumnDefinition(
          name: 'notifyOnEnter',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'notifyOnExit',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'safe_zone_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'safe_zone_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'safe_zone_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'settlement',
      dartName: 'Settlement',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'settlement_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'amount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'EUR\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SettlementStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'settledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'settlement_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'settlement_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'settlement_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'shopping_item',
      dartName: 'ShoppingItem',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'shopping_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'shoppingListId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ShoppingUnit',
          columnDefault: '\'pieces\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ShoppingCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isChecked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'checkedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'checkedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'priceEstimate',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'addedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isUrgent',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'shopping_item_fk_0',
          columns: ['shoppingListId'],
          referenceTable: 'shopping_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'shopping_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'shopping_item_list_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'shoppingListId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'shopping_list',
      dartName: 'ShoppingList',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'shopping_list_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'store',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ShoppingListStatus',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignedTo',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'shopping_list_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'shopping_list_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'shopping_list_family_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'todo_item',
      dartName: 'TodoItem',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'todo_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TodoCategory',
          columnDefault: '\'other\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TodoPriority',
          columnDefault: '\'medium\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TodoStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'assignedTo',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'points',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '10',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'todo_item_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'todo_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'todo_item_family_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'todo_item_family_assigned_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assignedTo',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_points',
      dartName: 'UserPoints',
      schema: 'public',
      module: 'famylia',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_points_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'familyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'points',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'streakDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'badgesJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'::text',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_points_fk_0',
          columns: ['familyId'],
          referenceTable: 'family',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_points_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_points_user_family_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'familyId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.BoardChanged) {
      return _i4.BoardChanged.fromJson(data) as T;
    }
    if (t == _i5.BoardPost) {
      return _i5.BoardPost.fromJson(data) as T;
    }
    if (t == _i6.BoardPostType) {
      return _i6.BoardPostType.fromJson(data) as T;
    }
    if (t == _i7.BoardPostWithPoll) {
      return _i7.BoardPostWithPoll.fromJson(data) as T;
    }
    if (t == _i8.CalendarEvent) {
      return _i8.CalendarEvent.fromJson(data) as T;
    }
    if (t == _i9.CalendarEventCategory) {
      return _i9.CalendarEventCategory.fromJson(data) as T;
    }
    if (t == _i10.Deadline) {
      return _i10.Deadline.fromJson(data) as T;
    }
    if (t == _i11.DeadlineCategory) {
      return _i11.DeadlineCategory.fromJson(data) as T;
    }
    if (t == _i12.DeadlinePriority) {
      return _i12.DeadlinePriority.fromJson(data) as T;
    }
    if (t == _i13.DeadlineStatus) {
      return _i13.DeadlineStatus.fromJson(data) as T;
    }
    if (t == _i14.DocumentAccessLevel) {
      return _i14.DocumentAccessLevel.fromJson(data) as T;
    }
    if (t == _i15.DocumentCategory) {
      return _i15.DocumentCategory.fromJson(data) as T;
    }
    if (t == _i16.DocumentFileType) {
      return _i16.DocumentFileType.fromJson(data) as T;
    }
    if (t == _i17.DocumentRecord) {
      return _i17.DocumentRecord.fromJson(data) as T;
    }
    if (t == _i18.EmergencyAlert) {
      return _i18.EmergencyAlert.fromJson(data) as T;
    }
    if (t == _i19.EmergencyAlertStatus) {
      return _i19.EmergencyAlertStatus.fromJson(data) as T;
    }
    if (t == _i20.EmergencyAlertType) {
      return _i20.EmergencyAlertType.fromJson(data) as T;
    }
    if (t == _i21.EmergencyChanged) {
      return _i21.EmergencyChanged.fromJson(data) as T;
    }
    if (t == _i22.EmergencyContact) {
      return _i22.EmergencyContact.fromJson(data) as T;
    }
    if (t == _i23.EmergencySettings) {
      return _i23.EmergencySettings.fromJson(data) as T;
    }
    if (t == _i24.EmergencyTriggerMethod) {
      return _i24.EmergencyTriggerMethod.fromJson(data) as T;
    }
    if (t == _i25.Expense) {
      return _i25.Expense.fromJson(data) as T;
    }
    if (t == _i26.ExpenseCategory) {
      return _i26.ExpenseCategory.fromJson(data) as T;
    }
    if (t == _i27.ExpenseSplitType) {
      return _i27.ExpenseSplitType.fromJson(data) as T;
    }
    if (t == _i28.ExpenseStatus) {
      return _i28.ExpenseStatus.fromJson(data) as T;
    }
    if (t == _i29.Family) {
      return _i29.Family.fromJson(data) as T;
    }
    if (t == _i30.FamilyBalance) {
      return _i30.FamilyBalance.fromJson(data) as T;
    }
    if (t == _i31.FamilyMember) {
      return _i31.FamilyMember.fromJson(data) as T;
    }
    if (t == _i32.FamilyMemberInfo) {
      return _i32.FamilyMemberInfo.fromJson(data) as T;
    }
    if (t == _i33.FamilyReport) {
      return _i33.FamilyReport.fromJson(data) as T;
    }
    if (t == _i34.FamilyRole) {
      return _i34.FamilyRole.fromJson(data) as T;
    }
    if (t == _i35.FamilyWithRole) {
      return _i35.FamilyWithRole.fromJson(data) as T;
    }
    if (t == _i36.FamyliaException) {
      return _i36.FamyliaException.fromJson(data) as T;
    }
    if (t == _i37.GdprExport) {
      return _i37.GdprExport.fromJson(data) as T;
    }
    if (t == _i38.HealthEntry) {
      return _i38.HealthEntry.fromJson(data) as T;
    }
    if (t == _i39.HealthEntryStatus) {
      return _i39.HealthEntryStatus.fromJson(data) as T;
    }
    if (t == _i40.HealthEntryType) {
      return _i40.HealthEntryType.fromJson(data) as T;
    }
    if (t == _i41.Leaderboard) {
      return _i41.Leaderboard.fromJson(data) as T;
    }
    if (t == _i42.LeaderboardEntry) {
      return _i42.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i43.LocationAccuracyLevel) {
      return _i43.LocationAccuracyLevel.fromJson(data) as T;
    }
    if (t == _i44.LocationHistory) {
      return _i44.LocationHistory.fromJson(data) as T;
    }
    if (t == _i45.LocationSharing) {
      return _i45.LocationSharing.fromJson(data) as T;
    }
    if (t == _i46.MealPlan) {
      return _i46.MealPlan.fromJson(data) as T;
    }
    if (t == _i47.MemberBalance) {
      return _i47.MemberBalance.fromJson(data) as T;
    }
    if (t == _i48.MemberLocation) {
      return _i48.MemberLocation.fromJson(data) as T;
    }
    if (t == _i49.PollOption) {
      return _i49.PollOption.fromJson(data) as T;
    }
    if (t == _i50.PrivacyDashboard) {
      return _i50.PrivacyDashboard.fromJson(data) as T;
    }
    if (t == _i51.Recipe) {
      return _i51.Recipe.fromJson(data) as T;
    }
    if (t == _i52.SafeZone) {
      return _i52.SafeZone.fromJson(data) as T;
    }
    if (t == _i53.Settlement) {
      return _i53.Settlement.fromJson(data) as T;
    }
    if (t == _i54.SettlementStatus) {
      return _i54.SettlementStatus.fromJson(data) as T;
    }
    if (t == _i55.SettlementSuggestion) {
      return _i55.SettlementSuggestion.fromJson(data) as T;
    }
    if (t == _i56.ShoppingCategory) {
      return _i56.ShoppingCategory.fromJson(data) as T;
    }
    if (t == _i57.ShoppingItem) {
      return _i57.ShoppingItem.fromJson(data) as T;
    }
    if (t == _i58.ShoppingList) {
      return _i58.ShoppingList.fromJson(data) as T;
    }
    if (t == _i59.ShoppingListChanged) {
      return _i59.ShoppingListChanged.fromJson(data) as T;
    }
    if (t == _i60.ShoppingListStatus) {
      return _i60.ShoppingListStatus.fromJson(data) as T;
    }
    if (t == _i61.ShoppingListWithItems) {
      return _i61.ShoppingListWithItems.fromJson(data) as T;
    }
    if (t == _i62.ShoppingUnit) {
      return _i62.ShoppingUnit.fromJson(data) as T;
    }
    if (t == _i63.SportIntensity) {
      return _i63.SportIntensity.fromJson(data) as T;
    }
    if (t == _i64.TodoCategory) {
      return _i64.TodoCategory.fromJson(data) as T;
    }
    if (t == _i65.TodoItem) {
      return _i65.TodoItem.fromJson(data) as T;
    }
    if (t == _i66.TodoPriority) {
      return _i66.TodoPriority.fromJson(data) as T;
    }
    if (t == _i67.TodoStatus) {
      return _i67.TodoStatus.fromJson(data) as T;
    }
    if (t == _i68.UserPoints) {
      return _i68.UserPoints.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.BoardChanged?>()) {
      return (data != null ? _i4.BoardChanged.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BoardPost?>()) {
      return (data != null ? _i5.BoardPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BoardPostType?>()) {
      return (data != null ? _i6.BoardPostType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BoardPostWithPoll?>()) {
      return (data != null ? _i7.BoardPostWithPoll.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CalendarEvent?>()) {
      return (data != null ? _i8.CalendarEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CalendarEventCategory?>()) {
      return (data != null ? _i9.CalendarEventCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.Deadline?>()) {
      return (data != null ? _i10.Deadline.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DeadlineCategory?>()) {
      return (data != null ? _i11.DeadlineCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DeadlinePriority?>()) {
      return (data != null ? _i12.DeadlinePriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.DeadlineStatus?>()) {
      return (data != null ? _i13.DeadlineStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DocumentAccessLevel?>()) {
      return (data != null ? _i14.DocumentAccessLevel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DocumentCategory?>()) {
      return (data != null ? _i15.DocumentCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DocumentFileType?>()) {
      return (data != null ? _i16.DocumentFileType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.DocumentRecord?>()) {
      return (data != null ? _i17.DocumentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.EmergencyAlert?>()) {
      return (data != null ? _i18.EmergencyAlert.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.EmergencyAlertStatus?>()) {
      return (data != null ? _i19.EmergencyAlertStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.EmergencyAlertType?>()) {
      return (data != null ? _i20.EmergencyAlertType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.EmergencyChanged?>()) {
      return (data != null ? _i21.EmergencyChanged.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.EmergencyContact?>()) {
      return (data != null ? _i22.EmergencyContact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.EmergencySettings?>()) {
      return (data != null ? _i23.EmergencySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.EmergencyTriggerMethod?>()) {
      return (data != null ? _i24.EmergencyTriggerMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Expense?>()) {
      return (data != null ? _i25.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ExpenseCategory?>()) {
      return (data != null ? _i26.ExpenseCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.ExpenseSplitType?>()) {
      return (data != null ? _i27.ExpenseSplitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ExpenseStatus?>()) {
      return (data != null ? _i28.ExpenseStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Family?>()) {
      return (data != null ? _i29.Family.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.FamilyBalance?>()) {
      return (data != null ? _i30.FamilyBalance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FamilyMember?>()) {
      return (data != null ? _i31.FamilyMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.FamilyMemberInfo?>()) {
      return (data != null ? _i32.FamilyMemberInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.FamilyReport?>()) {
      return (data != null ? _i33.FamilyReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.FamilyRole?>()) {
      return (data != null ? _i34.FamilyRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.FamilyWithRole?>()) {
      return (data != null ? _i35.FamilyWithRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.FamyliaException?>()) {
      return (data != null ? _i36.FamyliaException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.GdprExport?>()) {
      return (data != null ? _i37.GdprExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.HealthEntry?>()) {
      return (data != null ? _i38.HealthEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.HealthEntryStatus?>()) {
      return (data != null ? _i39.HealthEntryStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.HealthEntryType?>()) {
      return (data != null ? _i40.HealthEntryType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Leaderboard?>()) {
      return (data != null ? _i41.Leaderboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.LeaderboardEntry?>()) {
      return (data != null ? _i42.LeaderboardEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.LocationAccuracyLevel?>()) {
      return (data != null ? _i43.LocationAccuracyLevel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.LocationHistory?>()) {
      return (data != null ? _i44.LocationHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.LocationSharing?>()) {
      return (data != null ? _i45.LocationSharing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.MealPlan?>()) {
      return (data != null ? _i46.MealPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.MemberBalance?>()) {
      return (data != null ? _i47.MemberBalance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.MemberLocation?>()) {
      return (data != null ? _i48.MemberLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.PollOption?>()) {
      return (data != null ? _i49.PollOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.PrivacyDashboard?>()) {
      return (data != null ? _i50.PrivacyDashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.Recipe?>()) {
      return (data != null ? _i51.Recipe.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SafeZone?>()) {
      return (data != null ? _i52.SafeZone.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.Settlement?>()) {
      return (data != null ? _i53.Settlement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SettlementStatus?>()) {
      return (data != null ? _i54.SettlementStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SettlementSuggestion?>()) {
      return (data != null ? _i55.SettlementSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.ShoppingCategory?>()) {
      return (data != null ? _i56.ShoppingCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.ShoppingItem?>()) {
      return (data != null ? _i57.ShoppingItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.ShoppingList?>()) {
      return (data != null ? _i58.ShoppingList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.ShoppingListChanged?>()) {
      return (data != null ? _i59.ShoppingListChanged.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.ShoppingListStatus?>()) {
      return (data != null ? _i60.ShoppingListStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.ShoppingListWithItems?>()) {
      return (data != null ? _i61.ShoppingListWithItems.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.ShoppingUnit?>()) {
      return (data != null ? _i62.ShoppingUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.SportIntensity?>()) {
      return (data != null ? _i63.SportIntensity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.TodoCategory?>()) {
      return (data != null ? _i64.TodoCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.TodoItem?>()) {
      return (data != null ? _i65.TodoItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.TodoPriority?>()) {
      return (data != null ? _i66.TodoPriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.TodoStatus?>()) {
      return (data != null ? _i67.TodoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.UserPoints?>()) {
      return (data != null ? _i68.UserPoints.fromJson(data) : null) as T;
    }
    if (t == List<_i49.PollOption>) {
      return (data as List).map((e) => deserialize<_i49.PollOption>(e)).toList()
          as T;
    }
    if (t == List<_i47.MemberBalance>) {
      return (data as List)
          .map((e) => deserialize<_i47.MemberBalance>(e))
          .toList() as T;
    }
    if (t == List<_i55.SettlementSuggestion>) {
      return (data as List)
          .map((e) => deserialize<_i55.SettlementSuggestion>(e))
          .toList() as T;
    }
    if (t == List<_i42.LeaderboardEntry>) {
      return (data as List)
          .map((e) => deserialize<_i42.LeaderboardEntry>(e))
          .toList() as T;
    }
    if (t == List<_i57.ShoppingItem>) {
      return (data as List)
          .map((e) => deserialize<_i57.ShoppingItem>(e))
          .toList() as T;
    }
    if (t == List<_i69.BoardPostWithPoll>) {
      return (data as List)
          .map((e) => deserialize<_i69.BoardPostWithPoll>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<_i70.CalendarEvent>) {
      return (data as List)
          .map((e) => deserialize<_i70.CalendarEvent>(e))
          .toList() as T;
    }
    if (t == List<_i71.Deadline>) {
      return (data as List).map((e) => deserialize<_i71.Deadline>(e)).toList()
          as T;
    }
    if (t == List<_i72.DocumentRecord>) {
      return (data as List)
          .map((e) => deserialize<_i72.DocumentRecord>(e))
          .toList() as T;
    }
    if (t == List<_i73.EmergencyAlert>) {
      return (data as List)
          .map((e) => deserialize<_i73.EmergencyAlert>(e))
          .toList() as T;
    }
    if (t == List<_i74.EmergencyContact>) {
      return (data as List)
          .map((e) => deserialize<_i74.EmergencyContact>(e))
          .toList() as T;
    }
    if (t == List<_i75.Expense>) {
      return (data as List).map((e) => deserialize<_i75.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i76.Settlement>) {
      return (data as List).map((e) => deserialize<_i76.Settlement>(e)).toList()
          as T;
    }
    if (t == List<_i77.FamilyWithRole>) {
      return (data as List)
          .map((e) => deserialize<_i77.FamilyWithRole>(e))
          .toList() as T;
    }
    if (t == List<_i78.FamilyMemberInfo>) {
      return (data as List)
          .map((e) => deserialize<_i78.FamilyMemberInfo>(e))
          .toList() as T;
    }
    if (t == List<_i79.HealthEntry>) {
      return (data as List)
          .map((e) => deserialize<_i79.HealthEntry>(e))
          .toList() as T;
    }
    if (t == List<_i80.MemberLocation>) {
      return (data as List)
          .map((e) => deserialize<_i80.MemberLocation>(e))
          .toList() as T;
    }
    if (t == List<_i81.SafeZone>) {
      return (data as List).map((e) => deserialize<_i81.SafeZone>(e)).toList()
          as T;
    }
    if (t == List<_i82.Recipe>) {
      return (data as List).map((e) => deserialize<_i82.Recipe>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i83.ShoppingList>) {
      return (data as List)
          .map((e) => deserialize<_i83.ShoppingList>(e))
          .toList() as T;
    }
    if (t == List<_i84.TodoItem>) {
      return (data as List).map((e) => deserialize<_i84.TodoItem>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.BoardChanged) {
      return 'BoardChanged';
    }
    if (data is _i5.BoardPost) {
      return 'BoardPost';
    }
    if (data is _i6.BoardPostType) {
      return 'BoardPostType';
    }
    if (data is _i7.BoardPostWithPoll) {
      return 'BoardPostWithPoll';
    }
    if (data is _i8.CalendarEvent) {
      return 'CalendarEvent';
    }
    if (data is _i9.CalendarEventCategory) {
      return 'CalendarEventCategory';
    }
    if (data is _i10.Deadline) {
      return 'Deadline';
    }
    if (data is _i11.DeadlineCategory) {
      return 'DeadlineCategory';
    }
    if (data is _i12.DeadlinePriority) {
      return 'DeadlinePriority';
    }
    if (data is _i13.DeadlineStatus) {
      return 'DeadlineStatus';
    }
    if (data is _i14.DocumentAccessLevel) {
      return 'DocumentAccessLevel';
    }
    if (data is _i15.DocumentCategory) {
      return 'DocumentCategory';
    }
    if (data is _i16.DocumentFileType) {
      return 'DocumentFileType';
    }
    if (data is _i17.DocumentRecord) {
      return 'DocumentRecord';
    }
    if (data is _i18.EmergencyAlert) {
      return 'EmergencyAlert';
    }
    if (data is _i19.EmergencyAlertStatus) {
      return 'EmergencyAlertStatus';
    }
    if (data is _i20.EmergencyAlertType) {
      return 'EmergencyAlertType';
    }
    if (data is _i21.EmergencyChanged) {
      return 'EmergencyChanged';
    }
    if (data is _i22.EmergencyContact) {
      return 'EmergencyContact';
    }
    if (data is _i23.EmergencySettings) {
      return 'EmergencySettings';
    }
    if (data is _i24.EmergencyTriggerMethod) {
      return 'EmergencyTriggerMethod';
    }
    if (data is _i25.Expense) {
      return 'Expense';
    }
    if (data is _i26.ExpenseCategory) {
      return 'ExpenseCategory';
    }
    if (data is _i27.ExpenseSplitType) {
      return 'ExpenseSplitType';
    }
    if (data is _i28.ExpenseStatus) {
      return 'ExpenseStatus';
    }
    if (data is _i29.Family) {
      return 'Family';
    }
    if (data is _i30.FamilyBalance) {
      return 'FamilyBalance';
    }
    if (data is _i31.FamilyMember) {
      return 'FamilyMember';
    }
    if (data is _i32.FamilyMemberInfo) {
      return 'FamilyMemberInfo';
    }
    if (data is _i33.FamilyReport) {
      return 'FamilyReport';
    }
    if (data is _i34.FamilyRole) {
      return 'FamilyRole';
    }
    if (data is _i35.FamilyWithRole) {
      return 'FamilyWithRole';
    }
    if (data is _i36.FamyliaException) {
      return 'FamyliaException';
    }
    if (data is _i37.GdprExport) {
      return 'GdprExport';
    }
    if (data is _i38.HealthEntry) {
      return 'HealthEntry';
    }
    if (data is _i39.HealthEntryStatus) {
      return 'HealthEntryStatus';
    }
    if (data is _i40.HealthEntryType) {
      return 'HealthEntryType';
    }
    if (data is _i41.Leaderboard) {
      return 'Leaderboard';
    }
    if (data is _i42.LeaderboardEntry) {
      return 'LeaderboardEntry';
    }
    if (data is _i43.LocationAccuracyLevel) {
      return 'LocationAccuracyLevel';
    }
    if (data is _i44.LocationHistory) {
      return 'LocationHistory';
    }
    if (data is _i45.LocationSharing) {
      return 'LocationSharing';
    }
    if (data is _i46.MealPlan) {
      return 'MealPlan';
    }
    if (data is _i47.MemberBalance) {
      return 'MemberBalance';
    }
    if (data is _i48.MemberLocation) {
      return 'MemberLocation';
    }
    if (data is _i49.PollOption) {
      return 'PollOption';
    }
    if (data is _i50.PrivacyDashboard) {
      return 'PrivacyDashboard';
    }
    if (data is _i51.Recipe) {
      return 'Recipe';
    }
    if (data is _i52.SafeZone) {
      return 'SafeZone';
    }
    if (data is _i53.Settlement) {
      return 'Settlement';
    }
    if (data is _i54.SettlementStatus) {
      return 'SettlementStatus';
    }
    if (data is _i55.SettlementSuggestion) {
      return 'SettlementSuggestion';
    }
    if (data is _i56.ShoppingCategory) {
      return 'ShoppingCategory';
    }
    if (data is _i57.ShoppingItem) {
      return 'ShoppingItem';
    }
    if (data is _i58.ShoppingList) {
      return 'ShoppingList';
    }
    if (data is _i59.ShoppingListChanged) {
      return 'ShoppingListChanged';
    }
    if (data is _i60.ShoppingListStatus) {
      return 'ShoppingListStatus';
    }
    if (data is _i61.ShoppingListWithItems) {
      return 'ShoppingListWithItems';
    }
    if (data is _i62.ShoppingUnit) {
      return 'ShoppingUnit';
    }
    if (data is _i63.SportIntensity) {
      return 'SportIntensity';
    }
    if (data is _i64.TodoCategory) {
      return 'TodoCategory';
    }
    if (data is _i65.TodoItem) {
      return 'TodoItem';
    }
    if (data is _i66.TodoPriority) {
      return 'TodoPriority';
    }
    if (data is _i67.TodoStatus) {
      return 'TodoStatus';
    }
    if (data is _i68.UserPoints) {
      return 'UserPoints';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i69.BoardPostWithPoll>) {
      return 'List<BoardPostWithPoll>';
    }
    if (data is List<_i73.EmergencyAlert>) {
      return 'List<EmergencyAlert>';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BoardChanged') {
      return deserialize<_i4.BoardChanged>(data['data']);
    }
    if (dataClassName == 'BoardPost') {
      return deserialize<_i5.BoardPost>(data['data']);
    }
    if (dataClassName == 'BoardPostType') {
      return deserialize<_i6.BoardPostType>(data['data']);
    }
    if (dataClassName == 'BoardPostWithPoll') {
      return deserialize<_i7.BoardPostWithPoll>(data['data']);
    }
    if (dataClassName == 'CalendarEvent') {
      return deserialize<_i8.CalendarEvent>(data['data']);
    }
    if (dataClassName == 'CalendarEventCategory') {
      return deserialize<_i9.CalendarEventCategory>(data['data']);
    }
    if (dataClassName == 'Deadline') {
      return deserialize<_i10.Deadline>(data['data']);
    }
    if (dataClassName == 'DeadlineCategory') {
      return deserialize<_i11.DeadlineCategory>(data['data']);
    }
    if (dataClassName == 'DeadlinePriority') {
      return deserialize<_i12.DeadlinePriority>(data['data']);
    }
    if (dataClassName == 'DeadlineStatus') {
      return deserialize<_i13.DeadlineStatus>(data['data']);
    }
    if (dataClassName == 'DocumentAccessLevel') {
      return deserialize<_i14.DocumentAccessLevel>(data['data']);
    }
    if (dataClassName == 'DocumentCategory') {
      return deserialize<_i15.DocumentCategory>(data['data']);
    }
    if (dataClassName == 'DocumentFileType') {
      return deserialize<_i16.DocumentFileType>(data['data']);
    }
    if (dataClassName == 'DocumentRecord') {
      return deserialize<_i17.DocumentRecord>(data['data']);
    }
    if (dataClassName == 'EmergencyAlert') {
      return deserialize<_i18.EmergencyAlert>(data['data']);
    }
    if (dataClassName == 'EmergencyAlertStatus') {
      return deserialize<_i19.EmergencyAlertStatus>(data['data']);
    }
    if (dataClassName == 'EmergencyAlertType') {
      return deserialize<_i20.EmergencyAlertType>(data['data']);
    }
    if (dataClassName == 'EmergencyChanged') {
      return deserialize<_i21.EmergencyChanged>(data['data']);
    }
    if (dataClassName == 'EmergencyContact') {
      return deserialize<_i22.EmergencyContact>(data['data']);
    }
    if (dataClassName == 'EmergencySettings') {
      return deserialize<_i23.EmergencySettings>(data['data']);
    }
    if (dataClassName == 'EmergencyTriggerMethod') {
      return deserialize<_i24.EmergencyTriggerMethod>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i25.Expense>(data['data']);
    }
    if (dataClassName == 'ExpenseCategory') {
      return deserialize<_i26.ExpenseCategory>(data['data']);
    }
    if (dataClassName == 'ExpenseSplitType') {
      return deserialize<_i27.ExpenseSplitType>(data['data']);
    }
    if (dataClassName == 'ExpenseStatus') {
      return deserialize<_i28.ExpenseStatus>(data['data']);
    }
    if (dataClassName == 'Family') {
      return deserialize<_i29.Family>(data['data']);
    }
    if (dataClassName == 'FamilyBalance') {
      return deserialize<_i30.FamilyBalance>(data['data']);
    }
    if (dataClassName == 'FamilyMember') {
      return deserialize<_i31.FamilyMember>(data['data']);
    }
    if (dataClassName == 'FamilyMemberInfo') {
      return deserialize<_i32.FamilyMemberInfo>(data['data']);
    }
    if (dataClassName == 'FamilyReport') {
      return deserialize<_i33.FamilyReport>(data['data']);
    }
    if (dataClassName == 'FamilyRole') {
      return deserialize<_i34.FamilyRole>(data['data']);
    }
    if (dataClassName == 'FamilyWithRole') {
      return deserialize<_i35.FamilyWithRole>(data['data']);
    }
    if (dataClassName == 'FamyliaException') {
      return deserialize<_i36.FamyliaException>(data['data']);
    }
    if (dataClassName == 'GdprExport') {
      return deserialize<_i37.GdprExport>(data['data']);
    }
    if (dataClassName == 'HealthEntry') {
      return deserialize<_i38.HealthEntry>(data['data']);
    }
    if (dataClassName == 'HealthEntryStatus') {
      return deserialize<_i39.HealthEntryStatus>(data['data']);
    }
    if (dataClassName == 'HealthEntryType') {
      return deserialize<_i40.HealthEntryType>(data['data']);
    }
    if (dataClassName == 'Leaderboard') {
      return deserialize<_i41.Leaderboard>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_i42.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'LocationAccuracyLevel') {
      return deserialize<_i43.LocationAccuracyLevel>(data['data']);
    }
    if (dataClassName == 'LocationHistory') {
      return deserialize<_i44.LocationHistory>(data['data']);
    }
    if (dataClassName == 'LocationSharing') {
      return deserialize<_i45.LocationSharing>(data['data']);
    }
    if (dataClassName == 'MealPlan') {
      return deserialize<_i46.MealPlan>(data['data']);
    }
    if (dataClassName == 'MemberBalance') {
      return deserialize<_i47.MemberBalance>(data['data']);
    }
    if (dataClassName == 'MemberLocation') {
      return deserialize<_i48.MemberLocation>(data['data']);
    }
    if (dataClassName == 'PollOption') {
      return deserialize<_i49.PollOption>(data['data']);
    }
    if (dataClassName == 'PrivacyDashboard') {
      return deserialize<_i50.PrivacyDashboard>(data['data']);
    }
    if (dataClassName == 'Recipe') {
      return deserialize<_i51.Recipe>(data['data']);
    }
    if (dataClassName == 'SafeZone') {
      return deserialize<_i52.SafeZone>(data['data']);
    }
    if (dataClassName == 'Settlement') {
      return deserialize<_i53.Settlement>(data['data']);
    }
    if (dataClassName == 'SettlementStatus') {
      return deserialize<_i54.SettlementStatus>(data['data']);
    }
    if (dataClassName == 'SettlementSuggestion') {
      return deserialize<_i55.SettlementSuggestion>(data['data']);
    }
    if (dataClassName == 'ShoppingCategory') {
      return deserialize<_i56.ShoppingCategory>(data['data']);
    }
    if (dataClassName == 'ShoppingItem') {
      return deserialize<_i57.ShoppingItem>(data['data']);
    }
    if (dataClassName == 'ShoppingList') {
      return deserialize<_i58.ShoppingList>(data['data']);
    }
    if (dataClassName == 'ShoppingListChanged') {
      return deserialize<_i59.ShoppingListChanged>(data['data']);
    }
    if (dataClassName == 'ShoppingListStatus') {
      return deserialize<_i60.ShoppingListStatus>(data['data']);
    }
    if (dataClassName == 'ShoppingListWithItems') {
      return deserialize<_i61.ShoppingListWithItems>(data['data']);
    }
    if (dataClassName == 'ShoppingUnit') {
      return deserialize<_i62.ShoppingUnit>(data['data']);
    }
    if (dataClassName == 'SportIntensity') {
      return deserialize<_i63.SportIntensity>(data['data']);
    }
    if (dataClassName == 'TodoCategory') {
      return deserialize<_i64.TodoCategory>(data['data']);
    }
    if (dataClassName == 'TodoItem') {
      return deserialize<_i65.TodoItem>(data['data']);
    }
    if (dataClassName == 'TodoPriority') {
      return deserialize<_i66.TodoPriority>(data['data']);
    }
    if (dataClassName == 'TodoStatus') {
      return deserialize<_i67.TodoStatus>(data['data']);
    }
    if (dataClassName == 'UserPoints') {
      return deserialize<_i68.UserPoints>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<BoardPostWithPoll>') {
      return deserialize<List<_i69.BoardPostWithPoll>>(data['data']);
    }
    if (dataClassName == 'List<EmergencyAlert>') {
      return deserialize<List<_i73.EmergencyAlert>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.BoardPost:
        return _i5.BoardPost.t;
      case _i8.CalendarEvent:
        return _i8.CalendarEvent.t;
      case _i10.Deadline:
        return _i10.Deadline.t;
      case _i17.DocumentRecord:
        return _i17.DocumentRecord.t;
      case _i18.EmergencyAlert:
        return _i18.EmergencyAlert.t;
      case _i22.EmergencyContact:
        return _i22.EmergencyContact.t;
      case _i23.EmergencySettings:
        return _i23.EmergencySettings.t;
      case _i25.Expense:
        return _i25.Expense.t;
      case _i29.Family:
        return _i29.Family.t;
      case _i31.FamilyMember:
        return _i31.FamilyMember.t;
      case _i38.HealthEntry:
        return _i38.HealthEntry.t;
      case _i44.LocationHistory:
        return _i44.LocationHistory.t;
      case _i45.LocationSharing:
        return _i45.LocationSharing.t;
      case _i46.MealPlan:
        return _i46.MealPlan.t;
      case _i49.PollOption:
        return _i49.PollOption.t;
      case _i51.Recipe:
        return _i51.Recipe.t;
      case _i52.SafeZone:
        return _i52.SafeZone.t;
      case _i53.Settlement:
        return _i53.Settlement.t;
      case _i57.ShoppingItem:
        return _i57.ShoppingItem.t;
      case _i58.ShoppingList:
        return _i58.ShoppingList.t;
      case _i65.TodoItem:
        return _i65.TodoItem.t;
      case _i68.UserPoints:
        return _i68.UserPoints.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'famylia';
}
