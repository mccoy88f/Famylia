/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:famylia_client/src/protocol/board_post_with_poll.dart' as _i3;
import 'package:famylia_client/src/protocol/board_post_type.dart' as _i4;
import 'package:famylia_client/src/protocol/calendar_event.dart' as _i5;
import 'package:famylia_client/src/protocol/calendar_event_category.dart'
    as _i6;
import 'package:famylia_client/src/protocol/deadline.dart' as _i7;
import 'package:famylia_client/src/protocol/deadline_category.dart' as _i8;
import 'package:famylia_client/src/protocol/deadline_priority.dart' as _i9;
import 'package:famylia_client/src/protocol/deadline_status.dart' as _i10;
import 'package:famylia_client/src/protocol/document_record.dart' as _i11;
import 'package:famylia_client/src/protocol/document_category.dart' as _i12;
import 'dart:typed_data' as _i13;
import 'package:famylia_client/src/protocol/emergency_alert.dart' as _i14;
import 'package:famylia_client/src/protocol/emergency_settings.dart' as _i15;
import 'package:famylia_client/src/protocol/emergency_alert_type.dart' as _i16;
import 'package:famylia_client/src/protocol/emergency_contact.dart' as _i17;
import 'package:famylia_client/src/protocol/expense.dart' as _i18;
import 'package:famylia_client/src/protocol/expense_category.dart' as _i19;
import 'package:famylia_client/src/protocol/expense_split_type.dart' as _i20;
import 'package:famylia_client/src/protocol/family_balance.dart' as _i21;
import 'package:famylia_client/src/protocol/settlement.dart' as _i22;
import 'package:famylia_client/src/protocol/family.dart' as _i23;
import 'package:famylia_client/src/protocol/family_member.dart' as _i24;
import 'package:famylia_client/src/protocol/family_with_role.dart' as _i25;
import 'package:famylia_client/src/protocol/family_member_info.dart' as _i26;
import 'package:famylia_client/src/protocol/user_points.dart' as _i27;
import 'package:famylia_client/src/protocol/leaderboard.dart' as _i28;
import 'package:famylia_client/src/protocol/gdpr_export.dart' as _i29;
import 'package:famylia_client/src/protocol/privacy_dashboard.dart' as _i30;
import 'package:famylia_client/src/protocol/location_sharing.dart' as _i31;
import 'package:famylia_client/src/protocol/location_accuracy_level.dart'
    as _i32;
import 'package:famylia_client/src/protocol/location_history.dart' as _i33;
import 'package:famylia_client/src/protocol/member_location.dart' as _i34;
import 'package:famylia_client/src/protocol/safe_zone.dart' as _i35;
import 'package:famylia_client/src/protocol/recipe.dart' as _i36;
import 'package:famylia_client/src/protocol/meal_plan.dart' as _i37;
import 'package:famylia_client/src/protocol/family_report.dart' as _i38;
import 'package:famylia_client/src/protocol/shopping_list_with_items.dart'
    as _i39;
import 'package:famylia_client/src/protocol/shopping_list.dart' as _i40;
import 'package:famylia_client/src/protocol/shopping_list_status.dart' as _i41;
import 'package:famylia_client/src/protocol/shopping_item.dart' as _i42;
import 'package:famylia_client/src/protocol/shopping_unit.dart' as _i43;
import 'package:famylia_client/src/protocol/shopping_category.dart' as _i44;
import 'package:famylia_client/src/protocol/todo_item.dart' as _i45;
import 'package:famylia_client/src/protocol/todo_category.dart' as _i46;
import 'package:famylia_client/src/protocol/todo_priority.dart' as _i47;
import 'package:famylia_client/src/protocol/todo_status.dart' as _i48;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i49;
import 'protocol.dart' as _i50;

/// {@category Endpoint}
class EndpointBoard extends _i1.EndpointRef {
  EndpointBoard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'board';

  _i2.Stream<List<_i3.BoardPostWithPoll>> watchBoard(int familyId) =>
      caller.callStreamingServerEndpoint<
          _i2.Stream<List<_i3.BoardPostWithPoll>>, List<_i3.BoardPostWithPoll>>(
        'board',
        'watchBoard',
        {'familyId': familyId},
        {},
      );

  _i2.Future<List<_i3.BoardPostWithPoll>> listPosts(int familyId) =>
      caller.callServerEndpoint<List<_i3.BoardPostWithPoll>>(
        'board',
        'listPosts',
        {'familyId': familyId},
      );

  _i2.Future<_i3.BoardPostWithPoll> createPost(
    int familyId,
    String content, {
    String? title,
    _i4.BoardPostType? type,
    List<String>? pollOptions,
    bool? isPinned,
  }) =>
      caller.callServerEndpoint<_i3.BoardPostWithPoll>(
        'board',
        'createPost',
        {
          'familyId': familyId,
          'content': content,
          'title': title,
          'type': type,
          'pollOptions': pollOptions,
          'isPinned': isPinned,
        },
      );

  _i2.Future<_i3.BoardPostWithPoll> votePoll(int optionId) =>
      caller.callServerEndpoint<_i3.BoardPostWithPoll>(
        'board',
        'votePoll',
        {'optionId': optionId},
      );

  _i2.Future<bool> deletePost(int postId) => caller.callServerEndpoint<bool>(
        'board',
        'deletePost',
        {'postId': postId},
      );
}

/// {@category Endpoint}
class EndpointCalendar extends _i1.EndpointRef {
  EndpointCalendar(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'calendar';

  _i2.Future<_i5.CalendarEvent> createEvent(
    int familyId,
    String title,
    DateTime startAt, {
    String? description,
    _i6.CalendarEventCategory? category,
    DateTime? endAt,
    bool? isAllDay,
    String? location,
    int? assignedTo,
    bool? isPrivate,
    String? color,
  }) =>
      caller.callServerEndpoint<_i5.CalendarEvent>(
        'calendar',
        'createEvent',
        {
          'familyId': familyId,
          'title': title,
          'startAt': startAt,
          'description': description,
          'category': category,
          'endAt': endAt,
          'isAllDay': isAllDay,
          'location': location,
          'assignedTo': assignedTo,
          'isPrivate': isPrivate,
          'color': color,
        },
      );

  _i2.Future<List<_i5.CalendarEvent>> listEvents(
    int familyId,
    DateTime from,
    DateTime to,
  ) =>
      caller.callServerEndpoint<List<_i5.CalendarEvent>>(
        'calendar',
        'listEvents',
        {
          'familyId': familyId,
          'from': from,
          'to': to,
        },
      );

  _i2.Future<_i5.CalendarEvent> updateEvent(_i5.CalendarEvent event) =>
      caller.callServerEndpoint<_i5.CalendarEvent>(
        'calendar',
        'updateEvent',
        {'event': event},
      );

  _i2.Future<bool> deleteEvent(int eventId) => caller.callServerEndpoint<bool>(
        'calendar',
        'deleteEvent',
        {'eventId': eventId},
      );
}

/// {@category Endpoint}
class EndpointDeadline extends _i1.EndpointRef {
  EndpointDeadline(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'deadline';

  _i2.Future<_i7.Deadline> createDeadline(
    int familyId,
    String title,
    DateTime dueDate, {
    String? description,
    _i8.DeadlineCategory? category,
    double? amount,
    _i9.DeadlinePriority? priority,
    int? assignedTo,
    bool? isPrivate,
    bool? isRecurring,
    String? recurrenceRule,
  }) =>
      caller.callServerEndpoint<_i7.Deadline>(
        'deadline',
        'createDeadline',
        {
          'familyId': familyId,
          'title': title,
          'dueDate': dueDate,
          'description': description,
          'category': category,
          'amount': amount,
          'priority': priority,
          'assignedTo': assignedTo,
          'isPrivate': isPrivate,
          'isRecurring': isRecurring,
          'recurrenceRule': recurrenceRule,
        },
      );

  _i2.Future<List<_i7.Deadline>> listDeadlines(
    int familyId, {
    _i10.DeadlineStatus? status,
    _i8.DeadlineCategory? category,
  }) =>
      caller.callServerEndpoint<List<_i7.Deadline>>(
        'deadline',
        'listDeadlines',
        {
          'familyId': familyId,
          'status': status,
          'category': category,
        },
      );

  _i2.Future<List<_i7.Deadline>> upcoming(
    int familyId, {
    required int days,
  }) =>
      caller.callServerEndpoint<List<_i7.Deadline>>(
        'deadline',
        'upcoming',
        {
          'familyId': familyId,
          'days': days,
        },
      );

  _i2.Future<_i7.Deadline> completeDeadline(int deadlineId) =>
      caller.callServerEndpoint<_i7.Deadline>(
        'deadline',
        'completeDeadline',
        {'deadlineId': deadlineId},
      );

  _i2.Future<_i7.Deadline> updateDeadline(_i7.Deadline deadline) =>
      caller.callServerEndpoint<_i7.Deadline>(
        'deadline',
        'updateDeadline',
        {'deadline': deadline},
      );

  _i2.Future<bool> deleteDeadline(int deadlineId) =>
      caller.callServerEndpoint<bool>(
        'deadline',
        'deleteDeadline',
        {'deadlineId': deadlineId},
      );
}

/// Endpoint solo per sviluppo locale (codice verifica senza email).
/// {@category Endpoint}
class EndpointDev extends _i1.EndpointRef {
  EndpointDev(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dev';

  _i2.Future<String?> getVerificationCode(String email) =>
      caller.callServerEndpoint<String?>(
        'dev',
        'getVerificationCode',
        {'email': email},
      );
}

/// {@category Endpoint}
class EndpointDocument extends _i1.EndpointRef {
  EndpointDocument(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i2.Future<List<_i11.DocumentRecord>> listDocuments(
    int familyId, {
    _i12.DocumentCategory? category,
  }) =>
      caller.callServerEndpoint<List<_i11.DocumentRecord>>(
        'document',
        'listDocuments',
        {
          'familyId': familyId,
          'category': category,
        },
      );

  _i2.Future<_i11.DocumentRecord> uploadDocument(
    int familyId,
    String title,
    String fileName,
    _i13.ByteData fileBytes, {
    String? description,
    _i12.DocumentCategory? category,
    int? relatedDeadlineId,
    int? relatedExpenseId,
  }) =>
      caller.callServerEndpoint<_i11.DocumentRecord>(
        'document',
        'uploadDocument',
        {
          'familyId': familyId,
          'title': title,
          'fileName': fileName,
          'fileBytes': fileBytes,
          'description': description,
          'category': category,
          'relatedDeadlineId': relatedDeadlineId,
          'relatedExpenseId': relatedExpenseId,
        },
      );

  /// Placeholder OCR — popola metadati base (estensione futura Tesseract).
  _i2.Future<_i11.DocumentRecord> runOcr(int documentId) =>
      caller.callServerEndpoint<_i11.DocumentRecord>(
        'document',
        'runOcr',
        {'documentId': documentId},
      );

  _i2.Future<bool> deleteDocument(int documentId) =>
      caller.callServerEndpoint<bool>(
        'document',
        'deleteDocument',
        {'documentId': documentId},
      );
}

/// {@category Endpoint}
class EndpointEmergency extends _i1.EndpointRef {
  EndpointEmergency(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emergency';

  _i2.Stream<List<_i14.EmergencyAlert>> watchAlerts(int familyId) =>
      caller.callStreamingServerEndpoint<_i2.Stream<List<_i14.EmergencyAlert>>,
          List<_i14.EmergencyAlert>>(
        'emergency',
        'watchAlerts',
        {'familyId': familyId},
        {},
      );

  _i2.Future<_i15.EmergencySettings> getSettings(int familyId) =>
      caller.callServerEndpoint<_i15.EmergencySettings>(
        'emergency',
        'getSettings',
        {'familyId': familyId},
      );

  _i2.Future<_i15.EmergencySettings> updateSettings(
          _i15.EmergencySettings settings) =>
      caller.callServerEndpoint<_i15.EmergencySettings>(
        'emergency',
        'updateSettings',
        {'settings': settings},
      );

  _i2.Future<_i14.EmergencyAlert> triggerAlert(
    int familyId,
    _i16.EmergencyAlertType alertType, {
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    required bool isTest,
  }) =>
      caller.callServerEndpoint<_i14.EmergencyAlert>(
        'emergency',
        'triggerAlert',
        {
          'familyId': familyId,
          'alertType': alertType,
          'customMessage': customMessage,
          'locationLat': locationLat,
          'locationLng': locationLng,
          'locationAddress': locationAddress,
          'batteryLevel': batteryLevel,
          'isTest': isTest,
        },
      );

  _i2.Future<List<_i14.EmergencyAlert>> listActive(int familyId) =>
      caller.callServerEndpoint<List<_i14.EmergencyAlert>>(
        'emergency',
        'listActive',
        {'familyId': familyId},
      );

  _i2.Future<List<_i14.EmergencyAlert>> listHistory(int familyId) =>
      caller.callServerEndpoint<List<_i14.EmergencyAlert>>(
        'emergency',
        'listHistory',
        {'familyId': familyId},
      );

  _i2.Future<_i14.EmergencyAlert> acknowledge(int alertId) =>
      caller.callServerEndpoint<_i14.EmergencyAlert>(
        'emergency',
        'acknowledge',
        {'alertId': alertId},
      );

  _i2.Future<_i14.EmergencyAlert> resolve(int alertId) =>
      caller.callServerEndpoint<_i14.EmergencyAlert>(
        'emergency',
        'resolve',
        {'alertId': alertId},
      );

  _i2.Future<_i14.EmergencyAlert> markFalseAlarm(int alertId) =>
      caller.callServerEndpoint<_i14.EmergencyAlert>(
        'emergency',
        'markFalseAlarm',
        {'alertId': alertId},
      );

  _i2.Future<List<_i17.EmergencyContact>> listContacts(int familyId) =>
      caller.callServerEndpoint<List<_i17.EmergencyContact>>(
        'emergency',
        'listContacts',
        {'familyId': familyId},
      );

  _i2.Future<_i17.EmergencyContact> addContact(
    int familyId,
    String name,
    String phone, {
    String? email,
    int? priority,
  }) =>
      caller.callServerEndpoint<_i17.EmergencyContact>(
        'emergency',
        'addContact',
        {
          'familyId': familyId,
          'name': name,
          'phone': phone,
          'email': email,
          'priority': priority,
        },
      );

  _i2.Future<bool> deleteContact(int contactId) =>
      caller.callServerEndpoint<bool>(
        'emergency',
        'deleteContact',
        {'contactId': contactId},
      );
}

/// {@category Endpoint}
class EndpointExpense extends _i1.EndpointRef {
  EndpointExpense(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'expense';

  _i2.Future<_i18.Expense> createExpense(
    int familyId,
    String title,
    double amount,
    int paidBy, {
    String? description,
    _i19.ExpenseCategory? category,
    _i20.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    DateTime? expenseDate,
  }) =>
      caller.callServerEndpoint<_i18.Expense>(
        'expense',
        'createExpense',
        {
          'familyId': familyId,
          'title': title,
          'amount': amount,
          'paidBy': paidBy,
          'description': description,
          'category': category,
          'splitType': splitType,
          'splitDetailsJson': splitDetailsJson,
          'expenseDate': expenseDate,
        },
      );

  _i2.Future<List<_i18.Expense>> listExpenses(
    int familyId, {
    DateTime? from,
    DateTime? to,
  }) =>
      caller.callServerEndpoint<List<_i18.Expense>>(
        'expense',
        'listExpenses',
        {
          'familyId': familyId,
          'from': from,
          'to': to,
        },
      );

  _i2.Future<_i21.FamilyBalance> getBalance(int familyId) =>
      caller.callServerEndpoint<_i21.FamilyBalance>(
        'expense',
        'getBalance',
        {'familyId': familyId},
      );

  _i2.Future<_i22.Settlement> recordSettlement(
    int familyId,
    int fromUserId,
    int toUserId,
    double amount,
  ) =>
      caller.callServerEndpoint<_i22.Settlement>(
        'expense',
        'recordSettlement',
        {
          'familyId': familyId,
          'fromUserId': fromUserId,
          'toUserId': toUserId,
          'amount': amount,
        },
      );

  _i2.Future<List<_i22.Settlement>> listSettlements(int familyId) =>
      caller.callServerEndpoint<List<_i22.Settlement>>(
        'expense',
        'listSettlements',
        {'familyId': familyId},
      );

  _i2.Future<bool> deleteExpense(int expenseId) =>
      caller.callServerEndpoint<bool>(
        'expense',
        'deleteExpense',
        {'expenseId': expenseId},
      );
}

/// Gestione famiglie: creazione, join, elenco, membri.
/// {@category Endpoint}
class EndpointFamily extends _i1.EndpointRef {
  EndpointFamily(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'family';

  _i2.Future<_i23.Family> createFamily(String name) =>
      caller.callServerEndpoint<_i23.Family>(
        'family',
        'createFamily',
        {'name': name},
      );

  _i2.Future<_i24.FamilyMember> joinFamily(String inviteCode) =>
      caller.callServerEndpoint<_i24.FamilyMember>(
        'family',
        'joinFamily',
        {'inviteCode': inviteCode},
      );

  _i2.Future<List<_i25.FamilyWithRole>> listMyFamilies() =>
      caller.callServerEndpoint<List<_i25.FamilyWithRole>>(
        'family',
        'listMyFamilies',
        {},
      );

  _i2.Future<_i23.Family> getFamily(int familyId) =>
      caller.callServerEndpoint<_i23.Family>(
        'family',
        'getFamily',
        {'familyId': familyId},
      );

  _i2.Future<List<_i26.FamilyMemberInfo>> listMembers(int familyId) =>
      caller.callServerEndpoint<List<_i26.FamilyMemberInfo>>(
        'family',
        'listMembers',
        {'familyId': familyId},
      );

  _i2.Future<bool> leaveFamily(int familyId) => caller.callServerEndpoint<bool>(
        'family',
        'leaveFamily',
        {'familyId': familyId},
      );
}

/// {@category Endpoint}
class EndpointGamification extends _i1.EndpointRef {
  EndpointGamification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gamification';

  _i2.Future<_i27.UserPoints> getMyPoints(int familyId) =>
      caller.callServerEndpoint<_i27.UserPoints>(
        'gamification',
        'getMyPoints',
        {'familyId': familyId},
      );

  _i2.Future<_i28.Leaderboard> getLeaderboard(int familyId) =>
      caller.callServerEndpoint<_i28.Leaderboard>(
        'gamification',
        'getLeaderboard',
        {'familyId': familyId},
      );
}

/// {@category Endpoint}
class EndpointGdpr extends _i1.EndpointRef {
  EndpointGdpr(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gdpr';

  _i2.Future<_i29.GdprExport> exportMyData() =>
      caller.callServerEndpoint<_i29.GdprExport>(
        'gdpr',
        'exportMyData',
        {},
      );

  _i2.Future<bool> deleteMyAccount() => caller.callServerEndpoint<bool>(
        'gdpr',
        'deleteMyAccount',
        {},
      );

  _i2.Future<_i30.PrivacyDashboard> getPrivacyDashboard(int familyId) =>
      caller.callServerEndpoint<_i30.PrivacyDashboard>(
        'gdpr',
        'getPrivacyDashboard',
        {'familyId': familyId},
      );
}

/// {@category Endpoint}
class EndpointLocation extends _i1.EndpointRef {
  EndpointLocation(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'location';

  _i2.Future<_i31.LocationSharing> getStatus(int familyId) =>
      caller.callServerEndpoint<_i31.LocationSharing>(
        'location',
        'getStatus',
        {'familyId': familyId},
      );

  _i2.Future<_i31.LocationSharing> updateStatus(
    int familyId,
    bool isEnabled, {
    _i32.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
  }) =>
      caller.callServerEndpoint<_i31.LocationSharing>(
        'location',
        'updateStatus',
        {
          'familyId': familyId,
          'isEnabled': isEnabled,
          'accuracyLevel': accuracyLevel,
          'autoDisableAfterHours': autoDisableAfterHours,
        },
      );

  _i2.Future<_i33.LocationHistory> checkIn(
    int familyId,
    double latitude,
    double longitude, {
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
  }) =>
      caller.callServerEndpoint<_i33.LocationHistory>(
        'location',
        'checkIn',
        {
          'familyId': familyId,
          'latitude': latitude,
          'longitude': longitude,
          'accuracyMeters': accuracyMeters,
          'address': address,
          'batteryLevel': batteryLevel,
        },
      );

  _i2.Future<List<_i34.MemberLocation>> getFamilyLocations(int familyId) =>
      caller.callServerEndpoint<List<_i34.MemberLocation>>(
        'location',
        'getFamilyLocations',
        {'familyId': familyId},
      );

  _i2.Future<List<_i35.SafeZone>> listSafeZones(int familyId) =>
      caller.callServerEndpoint<List<_i35.SafeZone>>(
        'location',
        'listSafeZones',
        {'familyId': familyId},
      );

  _i2.Future<_i35.SafeZone> createSafeZone(
    int familyId,
    String name,
    double latitude,
    double longitude, {
    int? radiusMeters,
  }) =>
      caller.callServerEndpoint<_i35.SafeZone>(
        'location',
        'createSafeZone',
        {
          'familyId': familyId,
          'name': name,
          'latitude': latitude,
          'longitude': longitude,
          'radiusMeters': radiusMeters,
        },
      );
}

/// {@category Endpoint}
class EndpointMeal extends _i1.EndpointRef {
  EndpointMeal(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'meal';

  _i2.Future<_i36.Recipe> createRecipe(
    int familyId,
    String title, {
    String? description,
    String? ingredientsJson,
    int? servings,
  }) =>
      caller.callServerEndpoint<_i36.Recipe>(
        'meal',
        'createRecipe',
        {
          'familyId': familyId,
          'title': title,
          'description': description,
          'ingredientsJson': ingredientsJson,
          'servings': servings,
        },
      );

  _i2.Future<List<_i36.Recipe>> listRecipes(int familyId) =>
      caller.callServerEndpoint<List<_i36.Recipe>>(
        'meal',
        'listRecipes',
        {'familyId': familyId},
      );

  _i2.Future<_i37.MealPlan> saveMealPlan(
    int familyId,
    DateTime weekStart,
    String mealsJson,
  ) =>
      caller.callServerEndpoint<_i37.MealPlan>(
        'meal',
        'saveMealPlan',
        {
          'familyId': familyId,
          'weekStart': weekStart,
          'mealsJson': mealsJson,
        },
      );

  _i2.Future<_i37.MealPlan?> getMealPlan(
    int familyId,
    DateTime weekStart,
  ) =>
      caller.callServerEndpoint<_i37.MealPlan?>(
        'meal',
        'getMealPlan',
        {
          'familyId': familyId,
          'weekStart': weekStart,
        },
      );

  /// Genera voci lista spesa dagli ingredienti del piano settimanale.
  _i2.Future<List<String>> shoppingItemsFromPlan(
    int familyId,
    DateTime weekStart,
  ) =>
      caller.callServerEndpoint<List<String>>(
        'meal',
        'shoppingItemsFromPlan',
        {
          'familyId': familyId,
          'weekStart': weekStart,
        },
      );
}

/// {@category Endpoint}
class EndpointReport extends _i1.EndpointRef {
  EndpointReport(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'report';

  _i2.Future<_i38.FamilyReport> getReport(int familyId) =>
      caller.callServerEndpoint<_i38.FamilyReport>(
        'report',
        'getReport',
        {'familyId': familyId},
      );
}

/// {@category Endpoint}
class EndpointShopping extends _i1.EndpointRef {
  EndpointShopping(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shopping';

  /// Stream real-time: primo evento = stato attuale, poi ad ogni modifica.
  _i2.Stream<_i39.ShoppingListWithItems> watchList(int listId) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i39.ShoppingListWithItems>,
          _i39.ShoppingListWithItems>(
        'shopping',
        'watchList',
        {'listId': listId},
        {},
      );

  _i2.Future<_i40.ShoppingList> createList(
    int familyId,
    String name, {
    String? store,
    int? assignedTo,
    DateTime? dueDate,
  }) =>
      caller.callServerEndpoint<_i40.ShoppingList>(
        'shopping',
        'createList',
        {
          'familyId': familyId,
          'name': name,
          'store': store,
          'assignedTo': assignedTo,
          'dueDate': dueDate,
        },
      );

  _i2.Future<List<_i40.ShoppingList>> listLists(
    int familyId, {
    _i41.ShoppingListStatus? status,
  }) =>
      caller.callServerEndpoint<List<_i40.ShoppingList>>(
        'shopping',
        'listLists',
        {
          'familyId': familyId,
          'status': status,
        },
      );

  _i2.Future<_i39.ShoppingListWithItems> getList(int listId) =>
      caller.callServerEndpoint<_i39.ShoppingListWithItems>(
        'shopping',
        'getList',
        {'listId': listId},
      );

  _i2.Future<_i42.ShoppingItem> addItem(
    int listId,
    String name, {
    double? quantity,
    _i43.ShoppingUnit? unit,
    _i44.ShoppingCategory? category,
    String? notes,
    bool? isUrgent,
  }) =>
      caller.callServerEndpoint<_i42.ShoppingItem>(
        'shopping',
        'addItem',
        {
          'listId': listId,
          'name': name,
          'quantity': quantity,
          'unit': unit,
          'category': category,
          'notes': notes,
          'isUrgent': isUrgent,
        },
      );

  _i2.Future<_i42.ShoppingItem> updateItem(_i42.ShoppingItem item) =>
      caller.callServerEndpoint<_i42.ShoppingItem>(
        'shopping',
        'updateItem',
        {'item': item},
      );

  _i2.Future<_i42.ShoppingItem> checkItem(
    int itemId,
    bool isChecked,
  ) =>
      caller.callServerEndpoint<_i42.ShoppingItem>(
        'shopping',
        'checkItem',
        {
          'itemId': itemId,
          'isChecked': isChecked,
        },
      );

  _i2.Future<bool> deleteItem(int itemId) => caller.callServerEndpoint<bool>(
        'shopping',
        'deleteItem',
        {'itemId': itemId},
      );

  _i2.Future<_i40.ShoppingList> completeList(int listId) =>
      caller.callServerEndpoint<_i40.ShoppingList>(
        'shopping',
        'completeList',
        {'listId': listId},
      );
}

/// {@category Endpoint}
class EndpointTodo extends _i1.EndpointRef {
  EndpointTodo(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todo';

  _i2.Future<_i45.TodoItem> createTodo(
    int familyId,
    String title, {
    String? description,
    _i46.TodoCategory? category,
    _i47.TodoPriority? priority,
    int? assignedTo,
    DateTime? dueDate,
  }) =>
      caller.callServerEndpoint<_i45.TodoItem>(
        'todo',
        'createTodo',
        {
          'familyId': familyId,
          'title': title,
          'description': description,
          'category': category,
          'priority': priority,
          'assignedTo': assignedTo,
          'dueDate': dueDate,
        },
      );

  _i2.Future<List<_i45.TodoItem>> listTodos(
    int familyId, {
    _i48.TodoStatus? status,
  }) =>
      caller.callServerEndpoint<List<_i45.TodoItem>>(
        'todo',
        'listTodos',
        {
          'familyId': familyId,
          'status': status,
        },
      );

  /// Task di oggi per l'utente corrente (assegnati a me o senza assegnatario).
  _i2.Future<List<_i45.TodoItem>> myDay(int familyId) =>
      caller.callServerEndpoint<List<_i45.TodoItem>>(
        'todo',
        'myDay',
        {'familyId': familyId},
      );

  _i2.Future<_i45.TodoItem> assignTodo(
    int todoId,
    int? assignedTo,
  ) =>
      caller.callServerEndpoint<_i45.TodoItem>(
        'todo',
        'assignTodo',
        {
          'todoId': todoId,
          'assignedTo': assignedTo,
        },
      );

  _i2.Future<_i45.TodoItem> updateTodo(_i45.TodoItem item) =>
      caller.callServerEndpoint<_i45.TodoItem>(
        'todo',
        'updateTodo',
        {'item': item},
      );

  _i2.Future<_i45.TodoItem> completeTodo(int todoId) =>
      caller.callServerEndpoint<_i45.TodoItem>(
        'todo',
        'completeTodo',
        {'todoId': todoId},
      );

  _i2.Future<bool> deleteTodo(int todoId) => caller.callServerEndpoint<bool>(
        'todo',
        'deleteTodo',
        {'todoId': todoId},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i49.Caller(client);
  }

  late final _i49.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i50.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    board = EndpointBoard(this);
    calendar = EndpointCalendar(this);
    deadline = EndpointDeadline(this);
    dev = EndpointDev(this);
    document = EndpointDocument(this);
    emergency = EndpointEmergency(this);
    expense = EndpointExpense(this);
    family = EndpointFamily(this);
    gamification = EndpointGamification(this);
    gdpr = EndpointGdpr(this);
    location = EndpointLocation(this);
    meal = EndpointMeal(this);
    report = EndpointReport(this);
    shopping = EndpointShopping(this);
    todo = EndpointTodo(this);
    modules = Modules(this);
  }

  late final EndpointBoard board;

  late final EndpointCalendar calendar;

  late final EndpointDeadline deadline;

  late final EndpointDev dev;

  late final EndpointDocument document;

  late final EndpointEmergency emergency;

  late final EndpointExpense expense;

  late final EndpointFamily family;

  late final EndpointGamification gamification;

  late final EndpointGdpr gdpr;

  late final EndpointLocation location;

  late final EndpointMeal meal;

  late final EndpointReport report;

  late final EndpointShopping shopping;

  late final EndpointTodo todo;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'board': board,
        'calendar': calendar,
        'deadline': deadline,
        'dev': dev,
        'document': document,
        'emergency': emergency,
        'expense': expense,
        'family': family,
        'gamification': gamification,
        'gdpr': gdpr,
        'location': location,
        'meal': meal,
        'report': report,
        'shopping': shopping,
        'todo': todo,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
