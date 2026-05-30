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
import 'board_changed.dart' as _i2;
import 'board_post.dart' as _i3;
import 'board_post_type.dart' as _i4;
import 'board_post_with_poll.dart' as _i5;
import 'calendar_event.dart' as _i6;
import 'calendar_event_category.dart' as _i7;
import 'deadline.dart' as _i8;
import 'deadline_category.dart' as _i9;
import 'deadline_priority.dart' as _i10;
import 'deadline_status.dart' as _i11;
import 'document_access_level.dart' as _i12;
import 'document_category.dart' as _i13;
import 'document_file_type.dart' as _i14;
import 'document_record.dart' as _i15;
import 'emergency_alert.dart' as _i16;
import 'emergency_alert_status.dart' as _i17;
import 'emergency_alert_type.dart' as _i18;
import 'emergency_changed.dart' as _i19;
import 'emergency_contact.dart' as _i20;
import 'emergency_settings.dart' as _i21;
import 'emergency_trigger_method.dart' as _i22;
import 'expense.dart' as _i23;
import 'expense_category.dart' as _i24;
import 'expense_split_type.dart' as _i25;
import 'expense_status.dart' as _i26;
import 'family.dart' as _i27;
import 'family_balance.dart' as _i28;
import 'family_member.dart' as _i29;
import 'family_member_info.dart' as _i30;
import 'family_report.dart' as _i31;
import 'family_role.dart' as _i32;
import 'family_with_role.dart' as _i33;
import 'famylia_exception.dart' as _i34;
import 'gdpr_export.dart' as _i35;
import 'health_entry.dart' as _i36;
import 'health_entry_status.dart' as _i37;
import 'health_entry_type.dart' as _i38;
import 'leaderboard.dart' as _i39;
import 'leaderboard_entry.dart' as _i40;
import 'location_accuracy_level.dart' as _i41;
import 'location_history.dart' as _i42;
import 'location_sharing.dart' as _i43;
import 'meal_plan.dart' as _i44;
import 'member_balance.dart' as _i45;
import 'member_location.dart' as _i46;
import 'poll_option.dart' as _i47;
import 'privacy_dashboard.dart' as _i48;
import 'recipe.dart' as _i49;
import 'safe_zone.dart' as _i50;
import 'settlement.dart' as _i51;
import 'settlement_status.dart' as _i52;
import 'settlement_suggestion.dart' as _i53;
import 'shopping_category.dart' as _i54;
import 'shopping_item.dart' as _i55;
import 'shopping_list.dart' as _i56;
import 'shopping_list_changed.dart' as _i57;
import 'shopping_list_status.dart' as _i58;
import 'shopping_list_with_items.dart' as _i59;
import 'shopping_unit.dart' as _i60;
import 'sport_intensity.dart' as _i61;
import 'todo_category.dart' as _i62;
import 'todo_item.dart' as _i63;
import 'todo_priority.dart' as _i64;
import 'todo_status.dart' as _i65;
import 'user_points.dart' as _i66;
import 'package:famylia_client/src/protocol/board_post_with_poll.dart' as _i67;
import 'package:famylia_client/src/protocol/calendar_event.dart' as _i68;
import 'package:famylia_client/src/protocol/deadline.dart' as _i69;
import 'package:famylia_client/src/protocol/document_record.dart' as _i70;
import 'package:famylia_client/src/protocol/emergency_alert.dart' as _i71;
import 'package:famylia_client/src/protocol/emergency_contact.dart' as _i72;
import 'package:famylia_client/src/protocol/expense.dart' as _i73;
import 'package:famylia_client/src/protocol/settlement.dart' as _i74;
import 'package:famylia_client/src/protocol/family_with_role.dart' as _i75;
import 'package:famylia_client/src/protocol/family_member_info.dart' as _i76;
import 'package:famylia_client/src/protocol/health_entry.dart' as _i77;
import 'package:famylia_client/src/protocol/member_location.dart' as _i78;
import 'package:famylia_client/src/protocol/safe_zone.dart' as _i79;
import 'package:famylia_client/src/protocol/recipe.dart' as _i80;
import 'package:famylia_client/src/protocol/shopping_list.dart' as _i81;
import 'package:famylia_client/src/protocol/todo_item.dart' as _i82;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i83;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.BoardChanged) {
      return _i2.BoardChanged.fromJson(data) as T;
    }
    if (t == _i3.BoardPost) {
      return _i3.BoardPost.fromJson(data) as T;
    }
    if (t == _i4.BoardPostType) {
      return _i4.BoardPostType.fromJson(data) as T;
    }
    if (t == _i5.BoardPostWithPoll) {
      return _i5.BoardPostWithPoll.fromJson(data) as T;
    }
    if (t == _i6.CalendarEvent) {
      return _i6.CalendarEvent.fromJson(data) as T;
    }
    if (t == _i7.CalendarEventCategory) {
      return _i7.CalendarEventCategory.fromJson(data) as T;
    }
    if (t == _i8.Deadline) {
      return _i8.Deadline.fromJson(data) as T;
    }
    if (t == _i9.DeadlineCategory) {
      return _i9.DeadlineCategory.fromJson(data) as T;
    }
    if (t == _i10.DeadlinePriority) {
      return _i10.DeadlinePriority.fromJson(data) as T;
    }
    if (t == _i11.DeadlineStatus) {
      return _i11.DeadlineStatus.fromJson(data) as T;
    }
    if (t == _i12.DocumentAccessLevel) {
      return _i12.DocumentAccessLevel.fromJson(data) as T;
    }
    if (t == _i13.DocumentCategory) {
      return _i13.DocumentCategory.fromJson(data) as T;
    }
    if (t == _i14.DocumentFileType) {
      return _i14.DocumentFileType.fromJson(data) as T;
    }
    if (t == _i15.DocumentRecord) {
      return _i15.DocumentRecord.fromJson(data) as T;
    }
    if (t == _i16.EmergencyAlert) {
      return _i16.EmergencyAlert.fromJson(data) as T;
    }
    if (t == _i17.EmergencyAlertStatus) {
      return _i17.EmergencyAlertStatus.fromJson(data) as T;
    }
    if (t == _i18.EmergencyAlertType) {
      return _i18.EmergencyAlertType.fromJson(data) as T;
    }
    if (t == _i19.EmergencyChanged) {
      return _i19.EmergencyChanged.fromJson(data) as T;
    }
    if (t == _i20.EmergencyContact) {
      return _i20.EmergencyContact.fromJson(data) as T;
    }
    if (t == _i21.EmergencySettings) {
      return _i21.EmergencySettings.fromJson(data) as T;
    }
    if (t == _i22.EmergencyTriggerMethod) {
      return _i22.EmergencyTriggerMethod.fromJson(data) as T;
    }
    if (t == _i23.Expense) {
      return _i23.Expense.fromJson(data) as T;
    }
    if (t == _i24.ExpenseCategory) {
      return _i24.ExpenseCategory.fromJson(data) as T;
    }
    if (t == _i25.ExpenseSplitType) {
      return _i25.ExpenseSplitType.fromJson(data) as T;
    }
    if (t == _i26.ExpenseStatus) {
      return _i26.ExpenseStatus.fromJson(data) as T;
    }
    if (t == _i27.Family) {
      return _i27.Family.fromJson(data) as T;
    }
    if (t == _i28.FamilyBalance) {
      return _i28.FamilyBalance.fromJson(data) as T;
    }
    if (t == _i29.FamilyMember) {
      return _i29.FamilyMember.fromJson(data) as T;
    }
    if (t == _i30.FamilyMemberInfo) {
      return _i30.FamilyMemberInfo.fromJson(data) as T;
    }
    if (t == _i31.FamilyReport) {
      return _i31.FamilyReport.fromJson(data) as T;
    }
    if (t == _i32.FamilyRole) {
      return _i32.FamilyRole.fromJson(data) as T;
    }
    if (t == _i33.FamilyWithRole) {
      return _i33.FamilyWithRole.fromJson(data) as T;
    }
    if (t == _i34.FamyliaException) {
      return _i34.FamyliaException.fromJson(data) as T;
    }
    if (t == _i35.GdprExport) {
      return _i35.GdprExport.fromJson(data) as T;
    }
    if (t == _i36.HealthEntry) {
      return _i36.HealthEntry.fromJson(data) as T;
    }
    if (t == _i37.HealthEntryStatus) {
      return _i37.HealthEntryStatus.fromJson(data) as T;
    }
    if (t == _i38.HealthEntryType) {
      return _i38.HealthEntryType.fromJson(data) as T;
    }
    if (t == _i39.Leaderboard) {
      return _i39.Leaderboard.fromJson(data) as T;
    }
    if (t == _i40.LeaderboardEntry) {
      return _i40.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i41.LocationAccuracyLevel) {
      return _i41.LocationAccuracyLevel.fromJson(data) as T;
    }
    if (t == _i42.LocationHistory) {
      return _i42.LocationHistory.fromJson(data) as T;
    }
    if (t == _i43.LocationSharing) {
      return _i43.LocationSharing.fromJson(data) as T;
    }
    if (t == _i44.MealPlan) {
      return _i44.MealPlan.fromJson(data) as T;
    }
    if (t == _i45.MemberBalance) {
      return _i45.MemberBalance.fromJson(data) as T;
    }
    if (t == _i46.MemberLocation) {
      return _i46.MemberLocation.fromJson(data) as T;
    }
    if (t == _i47.PollOption) {
      return _i47.PollOption.fromJson(data) as T;
    }
    if (t == _i48.PrivacyDashboard) {
      return _i48.PrivacyDashboard.fromJson(data) as T;
    }
    if (t == _i49.Recipe) {
      return _i49.Recipe.fromJson(data) as T;
    }
    if (t == _i50.SafeZone) {
      return _i50.SafeZone.fromJson(data) as T;
    }
    if (t == _i51.Settlement) {
      return _i51.Settlement.fromJson(data) as T;
    }
    if (t == _i52.SettlementStatus) {
      return _i52.SettlementStatus.fromJson(data) as T;
    }
    if (t == _i53.SettlementSuggestion) {
      return _i53.SettlementSuggestion.fromJson(data) as T;
    }
    if (t == _i54.ShoppingCategory) {
      return _i54.ShoppingCategory.fromJson(data) as T;
    }
    if (t == _i55.ShoppingItem) {
      return _i55.ShoppingItem.fromJson(data) as T;
    }
    if (t == _i56.ShoppingList) {
      return _i56.ShoppingList.fromJson(data) as T;
    }
    if (t == _i57.ShoppingListChanged) {
      return _i57.ShoppingListChanged.fromJson(data) as T;
    }
    if (t == _i58.ShoppingListStatus) {
      return _i58.ShoppingListStatus.fromJson(data) as T;
    }
    if (t == _i59.ShoppingListWithItems) {
      return _i59.ShoppingListWithItems.fromJson(data) as T;
    }
    if (t == _i60.ShoppingUnit) {
      return _i60.ShoppingUnit.fromJson(data) as T;
    }
    if (t == _i61.SportIntensity) {
      return _i61.SportIntensity.fromJson(data) as T;
    }
    if (t == _i62.TodoCategory) {
      return _i62.TodoCategory.fromJson(data) as T;
    }
    if (t == _i63.TodoItem) {
      return _i63.TodoItem.fromJson(data) as T;
    }
    if (t == _i64.TodoPriority) {
      return _i64.TodoPriority.fromJson(data) as T;
    }
    if (t == _i65.TodoStatus) {
      return _i65.TodoStatus.fromJson(data) as T;
    }
    if (t == _i66.UserPoints) {
      return _i66.UserPoints.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BoardChanged?>()) {
      return (data != null ? _i2.BoardChanged.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BoardPost?>()) {
      return (data != null ? _i3.BoardPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BoardPostType?>()) {
      return (data != null ? _i4.BoardPostType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BoardPostWithPoll?>()) {
      return (data != null ? _i5.BoardPostWithPoll.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CalendarEvent?>()) {
      return (data != null ? _i6.CalendarEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CalendarEventCategory?>()) {
      return (data != null ? _i7.CalendarEventCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.Deadline?>()) {
      return (data != null ? _i8.Deadline.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DeadlineCategory?>()) {
      return (data != null ? _i9.DeadlineCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.DeadlinePriority?>()) {
      return (data != null ? _i10.DeadlinePriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DeadlineStatus?>()) {
      return (data != null ? _i11.DeadlineStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DocumentAccessLevel?>()) {
      return (data != null ? _i12.DocumentAccessLevel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DocumentCategory?>()) {
      return (data != null ? _i13.DocumentCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DocumentFileType?>()) {
      return (data != null ? _i14.DocumentFileType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.DocumentRecord?>()) {
      return (data != null ? _i15.DocumentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.EmergencyAlert?>()) {
      return (data != null ? _i16.EmergencyAlert.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.EmergencyAlertStatus?>()) {
      return (data != null ? _i17.EmergencyAlertStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.EmergencyAlertType?>()) {
      return (data != null ? _i18.EmergencyAlertType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.EmergencyChanged?>()) {
      return (data != null ? _i19.EmergencyChanged.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.EmergencyContact?>()) {
      return (data != null ? _i20.EmergencyContact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.EmergencySettings?>()) {
      return (data != null ? _i21.EmergencySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.EmergencyTriggerMethod?>()) {
      return (data != null ? _i22.EmergencyTriggerMethod.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Expense?>()) {
      return (data != null ? _i23.Expense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ExpenseCategory?>()) {
      return (data != null ? _i24.ExpenseCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ExpenseSplitType?>()) {
      return (data != null ? _i25.ExpenseSplitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ExpenseStatus?>()) {
      return (data != null ? _i26.ExpenseStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Family?>()) {
      return (data != null ? _i27.Family.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.FamilyBalance?>()) {
      return (data != null ? _i28.FamilyBalance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.FamilyMember?>()) {
      return (data != null ? _i29.FamilyMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.FamilyMemberInfo?>()) {
      return (data != null ? _i30.FamilyMemberInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FamilyReport?>()) {
      return (data != null ? _i31.FamilyReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.FamilyRole?>()) {
      return (data != null ? _i32.FamilyRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.FamilyWithRole?>()) {
      return (data != null ? _i33.FamilyWithRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.FamyliaException?>()) {
      return (data != null ? _i34.FamyliaException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.GdprExport?>()) {
      return (data != null ? _i35.GdprExport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.HealthEntry?>()) {
      return (data != null ? _i36.HealthEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.HealthEntryStatus?>()) {
      return (data != null ? _i37.HealthEntryStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.HealthEntryType?>()) {
      return (data != null ? _i38.HealthEntryType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.Leaderboard?>()) {
      return (data != null ? _i39.Leaderboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.LeaderboardEntry?>()) {
      return (data != null ? _i40.LeaderboardEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.LocationAccuracyLevel?>()) {
      return (data != null ? _i41.LocationAccuracyLevel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.LocationHistory?>()) {
      return (data != null ? _i42.LocationHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.LocationSharing?>()) {
      return (data != null ? _i43.LocationSharing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.MealPlan?>()) {
      return (data != null ? _i44.MealPlan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.MemberBalance?>()) {
      return (data != null ? _i45.MemberBalance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.MemberLocation?>()) {
      return (data != null ? _i46.MemberLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.PollOption?>()) {
      return (data != null ? _i47.PollOption.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.PrivacyDashboard?>()) {
      return (data != null ? _i48.PrivacyDashboard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.Recipe?>()) {
      return (data != null ? _i49.Recipe.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SafeZone?>()) {
      return (data != null ? _i50.SafeZone.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.Settlement?>()) {
      return (data != null ? _i51.Settlement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SettlementStatus?>()) {
      return (data != null ? _i52.SettlementStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SettlementSuggestion?>()) {
      return (data != null ? _i53.SettlementSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.ShoppingCategory?>()) {
      return (data != null ? _i54.ShoppingCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.ShoppingItem?>()) {
      return (data != null ? _i55.ShoppingItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.ShoppingList?>()) {
      return (data != null ? _i56.ShoppingList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.ShoppingListChanged?>()) {
      return (data != null ? _i57.ShoppingListChanged.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.ShoppingListStatus?>()) {
      return (data != null ? _i58.ShoppingListStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.ShoppingListWithItems?>()) {
      return (data != null ? _i59.ShoppingListWithItems.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.ShoppingUnit?>()) {
      return (data != null ? _i60.ShoppingUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.SportIntensity?>()) {
      return (data != null ? _i61.SportIntensity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.TodoCategory?>()) {
      return (data != null ? _i62.TodoCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.TodoItem?>()) {
      return (data != null ? _i63.TodoItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.TodoPriority?>()) {
      return (data != null ? _i64.TodoPriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.TodoStatus?>()) {
      return (data != null ? _i65.TodoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.UserPoints?>()) {
      return (data != null ? _i66.UserPoints.fromJson(data) : null) as T;
    }
    if (t == List<_i47.PollOption>) {
      return (data as List).map((e) => deserialize<_i47.PollOption>(e)).toList()
          as T;
    }
    if (t == List<_i45.MemberBalance>) {
      return (data as List)
          .map((e) => deserialize<_i45.MemberBalance>(e))
          .toList() as T;
    }
    if (t == List<_i53.SettlementSuggestion>) {
      return (data as List)
          .map((e) => deserialize<_i53.SettlementSuggestion>(e))
          .toList() as T;
    }
    if (t == List<_i40.LeaderboardEntry>) {
      return (data as List)
          .map((e) => deserialize<_i40.LeaderboardEntry>(e))
          .toList() as T;
    }
    if (t == List<_i55.ShoppingItem>) {
      return (data as List)
          .map((e) => deserialize<_i55.ShoppingItem>(e))
          .toList() as T;
    }
    if (t == List<_i67.BoardPostWithPoll>) {
      return (data as List)
          .map((e) => deserialize<_i67.BoardPostWithPoll>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<_i68.CalendarEvent>) {
      return (data as List)
          .map((e) => deserialize<_i68.CalendarEvent>(e))
          .toList() as T;
    }
    if (t == List<_i69.Deadline>) {
      return (data as List).map((e) => deserialize<_i69.Deadline>(e)).toList()
          as T;
    }
    if (t == List<_i70.DocumentRecord>) {
      return (data as List)
          .map((e) => deserialize<_i70.DocumentRecord>(e))
          .toList() as T;
    }
    if (t == List<_i71.EmergencyAlert>) {
      return (data as List)
          .map((e) => deserialize<_i71.EmergencyAlert>(e))
          .toList() as T;
    }
    if (t == List<_i72.EmergencyContact>) {
      return (data as List)
          .map((e) => deserialize<_i72.EmergencyContact>(e))
          .toList() as T;
    }
    if (t == List<_i73.Expense>) {
      return (data as List).map((e) => deserialize<_i73.Expense>(e)).toList()
          as T;
    }
    if (t == List<_i74.Settlement>) {
      return (data as List).map((e) => deserialize<_i74.Settlement>(e)).toList()
          as T;
    }
    if (t == List<_i75.FamilyWithRole>) {
      return (data as List)
          .map((e) => deserialize<_i75.FamilyWithRole>(e))
          .toList() as T;
    }
    if (t == List<_i76.FamilyMemberInfo>) {
      return (data as List)
          .map((e) => deserialize<_i76.FamilyMemberInfo>(e))
          .toList() as T;
    }
    if (t == List<_i77.HealthEntry>) {
      return (data as List)
          .map((e) => deserialize<_i77.HealthEntry>(e))
          .toList() as T;
    }
    if (t == List<_i78.MemberLocation>) {
      return (data as List)
          .map((e) => deserialize<_i78.MemberLocation>(e))
          .toList() as T;
    }
    if (t == List<_i79.SafeZone>) {
      return (data as List).map((e) => deserialize<_i79.SafeZone>(e)).toList()
          as T;
    }
    if (t == List<_i80.Recipe>) {
      return (data as List).map((e) => deserialize<_i80.Recipe>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i81.ShoppingList>) {
      return (data as List)
          .map((e) => deserialize<_i81.ShoppingList>(e))
          .toList() as T;
    }
    if (t == List<_i82.TodoItem>) {
      return (data as List).map((e) => deserialize<_i82.TodoItem>(e)).toList()
          as T;
    }
    try {
      return _i83.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.BoardChanged) {
      return 'BoardChanged';
    }
    if (data is _i3.BoardPost) {
      return 'BoardPost';
    }
    if (data is _i4.BoardPostType) {
      return 'BoardPostType';
    }
    if (data is _i5.BoardPostWithPoll) {
      return 'BoardPostWithPoll';
    }
    if (data is _i6.CalendarEvent) {
      return 'CalendarEvent';
    }
    if (data is _i7.CalendarEventCategory) {
      return 'CalendarEventCategory';
    }
    if (data is _i8.Deadline) {
      return 'Deadline';
    }
    if (data is _i9.DeadlineCategory) {
      return 'DeadlineCategory';
    }
    if (data is _i10.DeadlinePriority) {
      return 'DeadlinePriority';
    }
    if (data is _i11.DeadlineStatus) {
      return 'DeadlineStatus';
    }
    if (data is _i12.DocumentAccessLevel) {
      return 'DocumentAccessLevel';
    }
    if (data is _i13.DocumentCategory) {
      return 'DocumentCategory';
    }
    if (data is _i14.DocumentFileType) {
      return 'DocumentFileType';
    }
    if (data is _i15.DocumentRecord) {
      return 'DocumentRecord';
    }
    if (data is _i16.EmergencyAlert) {
      return 'EmergencyAlert';
    }
    if (data is _i17.EmergencyAlertStatus) {
      return 'EmergencyAlertStatus';
    }
    if (data is _i18.EmergencyAlertType) {
      return 'EmergencyAlertType';
    }
    if (data is _i19.EmergencyChanged) {
      return 'EmergencyChanged';
    }
    if (data is _i20.EmergencyContact) {
      return 'EmergencyContact';
    }
    if (data is _i21.EmergencySettings) {
      return 'EmergencySettings';
    }
    if (data is _i22.EmergencyTriggerMethod) {
      return 'EmergencyTriggerMethod';
    }
    if (data is _i23.Expense) {
      return 'Expense';
    }
    if (data is _i24.ExpenseCategory) {
      return 'ExpenseCategory';
    }
    if (data is _i25.ExpenseSplitType) {
      return 'ExpenseSplitType';
    }
    if (data is _i26.ExpenseStatus) {
      return 'ExpenseStatus';
    }
    if (data is _i27.Family) {
      return 'Family';
    }
    if (data is _i28.FamilyBalance) {
      return 'FamilyBalance';
    }
    if (data is _i29.FamilyMember) {
      return 'FamilyMember';
    }
    if (data is _i30.FamilyMemberInfo) {
      return 'FamilyMemberInfo';
    }
    if (data is _i31.FamilyReport) {
      return 'FamilyReport';
    }
    if (data is _i32.FamilyRole) {
      return 'FamilyRole';
    }
    if (data is _i33.FamilyWithRole) {
      return 'FamilyWithRole';
    }
    if (data is _i34.FamyliaException) {
      return 'FamyliaException';
    }
    if (data is _i35.GdprExport) {
      return 'GdprExport';
    }
    if (data is _i36.HealthEntry) {
      return 'HealthEntry';
    }
    if (data is _i37.HealthEntryStatus) {
      return 'HealthEntryStatus';
    }
    if (data is _i38.HealthEntryType) {
      return 'HealthEntryType';
    }
    if (data is _i39.Leaderboard) {
      return 'Leaderboard';
    }
    if (data is _i40.LeaderboardEntry) {
      return 'LeaderboardEntry';
    }
    if (data is _i41.LocationAccuracyLevel) {
      return 'LocationAccuracyLevel';
    }
    if (data is _i42.LocationHistory) {
      return 'LocationHistory';
    }
    if (data is _i43.LocationSharing) {
      return 'LocationSharing';
    }
    if (data is _i44.MealPlan) {
      return 'MealPlan';
    }
    if (data is _i45.MemberBalance) {
      return 'MemberBalance';
    }
    if (data is _i46.MemberLocation) {
      return 'MemberLocation';
    }
    if (data is _i47.PollOption) {
      return 'PollOption';
    }
    if (data is _i48.PrivacyDashboard) {
      return 'PrivacyDashboard';
    }
    if (data is _i49.Recipe) {
      return 'Recipe';
    }
    if (data is _i50.SafeZone) {
      return 'SafeZone';
    }
    if (data is _i51.Settlement) {
      return 'Settlement';
    }
    if (data is _i52.SettlementStatus) {
      return 'SettlementStatus';
    }
    if (data is _i53.SettlementSuggestion) {
      return 'SettlementSuggestion';
    }
    if (data is _i54.ShoppingCategory) {
      return 'ShoppingCategory';
    }
    if (data is _i55.ShoppingItem) {
      return 'ShoppingItem';
    }
    if (data is _i56.ShoppingList) {
      return 'ShoppingList';
    }
    if (data is _i57.ShoppingListChanged) {
      return 'ShoppingListChanged';
    }
    if (data is _i58.ShoppingListStatus) {
      return 'ShoppingListStatus';
    }
    if (data is _i59.ShoppingListWithItems) {
      return 'ShoppingListWithItems';
    }
    if (data is _i60.ShoppingUnit) {
      return 'ShoppingUnit';
    }
    if (data is _i61.SportIntensity) {
      return 'SportIntensity';
    }
    if (data is _i62.TodoCategory) {
      return 'TodoCategory';
    }
    if (data is _i63.TodoItem) {
      return 'TodoItem';
    }
    if (data is _i64.TodoPriority) {
      return 'TodoPriority';
    }
    if (data is _i65.TodoStatus) {
      return 'TodoStatus';
    }
    if (data is _i66.UserPoints) {
      return 'UserPoints';
    }
    className = _i83.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is List<_i67.BoardPostWithPoll>) {
      return 'List<BoardPostWithPoll>';
    }
    if (data is List<_i71.EmergencyAlert>) {
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
      return deserialize<_i2.BoardChanged>(data['data']);
    }
    if (dataClassName == 'BoardPost') {
      return deserialize<_i3.BoardPost>(data['data']);
    }
    if (dataClassName == 'BoardPostType') {
      return deserialize<_i4.BoardPostType>(data['data']);
    }
    if (dataClassName == 'BoardPostWithPoll') {
      return deserialize<_i5.BoardPostWithPoll>(data['data']);
    }
    if (dataClassName == 'CalendarEvent') {
      return deserialize<_i6.CalendarEvent>(data['data']);
    }
    if (dataClassName == 'CalendarEventCategory') {
      return deserialize<_i7.CalendarEventCategory>(data['data']);
    }
    if (dataClassName == 'Deadline') {
      return deserialize<_i8.Deadline>(data['data']);
    }
    if (dataClassName == 'DeadlineCategory') {
      return deserialize<_i9.DeadlineCategory>(data['data']);
    }
    if (dataClassName == 'DeadlinePriority') {
      return deserialize<_i10.DeadlinePriority>(data['data']);
    }
    if (dataClassName == 'DeadlineStatus') {
      return deserialize<_i11.DeadlineStatus>(data['data']);
    }
    if (dataClassName == 'DocumentAccessLevel') {
      return deserialize<_i12.DocumentAccessLevel>(data['data']);
    }
    if (dataClassName == 'DocumentCategory') {
      return deserialize<_i13.DocumentCategory>(data['data']);
    }
    if (dataClassName == 'DocumentFileType') {
      return deserialize<_i14.DocumentFileType>(data['data']);
    }
    if (dataClassName == 'DocumentRecord') {
      return deserialize<_i15.DocumentRecord>(data['data']);
    }
    if (dataClassName == 'EmergencyAlert') {
      return deserialize<_i16.EmergencyAlert>(data['data']);
    }
    if (dataClassName == 'EmergencyAlertStatus') {
      return deserialize<_i17.EmergencyAlertStatus>(data['data']);
    }
    if (dataClassName == 'EmergencyAlertType') {
      return deserialize<_i18.EmergencyAlertType>(data['data']);
    }
    if (dataClassName == 'EmergencyChanged') {
      return deserialize<_i19.EmergencyChanged>(data['data']);
    }
    if (dataClassName == 'EmergencyContact') {
      return deserialize<_i20.EmergencyContact>(data['data']);
    }
    if (dataClassName == 'EmergencySettings') {
      return deserialize<_i21.EmergencySettings>(data['data']);
    }
    if (dataClassName == 'EmergencyTriggerMethod') {
      return deserialize<_i22.EmergencyTriggerMethod>(data['data']);
    }
    if (dataClassName == 'Expense') {
      return deserialize<_i23.Expense>(data['data']);
    }
    if (dataClassName == 'ExpenseCategory') {
      return deserialize<_i24.ExpenseCategory>(data['data']);
    }
    if (dataClassName == 'ExpenseSplitType') {
      return deserialize<_i25.ExpenseSplitType>(data['data']);
    }
    if (dataClassName == 'ExpenseStatus') {
      return deserialize<_i26.ExpenseStatus>(data['data']);
    }
    if (dataClassName == 'Family') {
      return deserialize<_i27.Family>(data['data']);
    }
    if (dataClassName == 'FamilyBalance') {
      return deserialize<_i28.FamilyBalance>(data['data']);
    }
    if (dataClassName == 'FamilyMember') {
      return deserialize<_i29.FamilyMember>(data['data']);
    }
    if (dataClassName == 'FamilyMemberInfo') {
      return deserialize<_i30.FamilyMemberInfo>(data['data']);
    }
    if (dataClassName == 'FamilyReport') {
      return deserialize<_i31.FamilyReport>(data['data']);
    }
    if (dataClassName == 'FamilyRole') {
      return deserialize<_i32.FamilyRole>(data['data']);
    }
    if (dataClassName == 'FamilyWithRole') {
      return deserialize<_i33.FamilyWithRole>(data['data']);
    }
    if (dataClassName == 'FamyliaException') {
      return deserialize<_i34.FamyliaException>(data['data']);
    }
    if (dataClassName == 'GdprExport') {
      return deserialize<_i35.GdprExport>(data['data']);
    }
    if (dataClassName == 'HealthEntry') {
      return deserialize<_i36.HealthEntry>(data['data']);
    }
    if (dataClassName == 'HealthEntryStatus') {
      return deserialize<_i37.HealthEntryStatus>(data['data']);
    }
    if (dataClassName == 'HealthEntryType') {
      return deserialize<_i38.HealthEntryType>(data['data']);
    }
    if (dataClassName == 'Leaderboard') {
      return deserialize<_i39.Leaderboard>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_i40.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'LocationAccuracyLevel') {
      return deserialize<_i41.LocationAccuracyLevel>(data['data']);
    }
    if (dataClassName == 'LocationHistory') {
      return deserialize<_i42.LocationHistory>(data['data']);
    }
    if (dataClassName == 'LocationSharing') {
      return deserialize<_i43.LocationSharing>(data['data']);
    }
    if (dataClassName == 'MealPlan') {
      return deserialize<_i44.MealPlan>(data['data']);
    }
    if (dataClassName == 'MemberBalance') {
      return deserialize<_i45.MemberBalance>(data['data']);
    }
    if (dataClassName == 'MemberLocation') {
      return deserialize<_i46.MemberLocation>(data['data']);
    }
    if (dataClassName == 'PollOption') {
      return deserialize<_i47.PollOption>(data['data']);
    }
    if (dataClassName == 'PrivacyDashboard') {
      return deserialize<_i48.PrivacyDashboard>(data['data']);
    }
    if (dataClassName == 'Recipe') {
      return deserialize<_i49.Recipe>(data['data']);
    }
    if (dataClassName == 'SafeZone') {
      return deserialize<_i50.SafeZone>(data['data']);
    }
    if (dataClassName == 'Settlement') {
      return deserialize<_i51.Settlement>(data['data']);
    }
    if (dataClassName == 'SettlementStatus') {
      return deserialize<_i52.SettlementStatus>(data['data']);
    }
    if (dataClassName == 'SettlementSuggestion') {
      return deserialize<_i53.SettlementSuggestion>(data['data']);
    }
    if (dataClassName == 'ShoppingCategory') {
      return deserialize<_i54.ShoppingCategory>(data['data']);
    }
    if (dataClassName == 'ShoppingItem') {
      return deserialize<_i55.ShoppingItem>(data['data']);
    }
    if (dataClassName == 'ShoppingList') {
      return deserialize<_i56.ShoppingList>(data['data']);
    }
    if (dataClassName == 'ShoppingListChanged') {
      return deserialize<_i57.ShoppingListChanged>(data['data']);
    }
    if (dataClassName == 'ShoppingListStatus') {
      return deserialize<_i58.ShoppingListStatus>(data['data']);
    }
    if (dataClassName == 'ShoppingListWithItems') {
      return deserialize<_i59.ShoppingListWithItems>(data['data']);
    }
    if (dataClassName == 'ShoppingUnit') {
      return deserialize<_i60.ShoppingUnit>(data['data']);
    }
    if (dataClassName == 'SportIntensity') {
      return deserialize<_i61.SportIntensity>(data['data']);
    }
    if (dataClassName == 'TodoCategory') {
      return deserialize<_i62.TodoCategory>(data['data']);
    }
    if (dataClassName == 'TodoItem') {
      return deserialize<_i63.TodoItem>(data['data']);
    }
    if (dataClassName == 'TodoPriority') {
      return deserialize<_i64.TodoPriority>(data['data']);
    }
    if (dataClassName == 'TodoStatus') {
      return deserialize<_i65.TodoStatus>(data['data']);
    }
    if (dataClassName == 'UserPoints') {
      return deserialize<_i66.UserPoints>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i83.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<BoardPostWithPoll>') {
      return deserialize<List<_i67.BoardPostWithPoll>>(data['data']);
    }
    if (dataClassName == 'List<EmergencyAlert>') {
      return deserialize<List<_i71.EmergencyAlert>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
