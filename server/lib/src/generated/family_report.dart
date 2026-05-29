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

abstract class FamilyReport
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FamilyReport._({
    required this.openTodos,
    required this.completedTodos,
    required this.totalExpenses,
    required this.upcomingDeadlines,
    required this.activeShoppingLists,
    required this.csvExport,
  });

  factory FamilyReport({
    required int openTodos,
    required int completedTodos,
    required double totalExpenses,
    required int upcomingDeadlines,
    required int activeShoppingLists,
    required String csvExport,
  }) = _FamilyReportImpl;

  factory FamilyReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyReport(
      openTodos: jsonSerialization['openTodos'] as int,
      completedTodos: jsonSerialization['completedTodos'] as int,
      totalExpenses: (jsonSerialization['totalExpenses'] as num).toDouble(),
      upcomingDeadlines: jsonSerialization['upcomingDeadlines'] as int,
      activeShoppingLists: jsonSerialization['activeShoppingLists'] as int,
      csvExport: jsonSerialization['csvExport'] as String,
    );
  }

  int openTodos;

  int completedTodos;

  double totalExpenses;

  int upcomingDeadlines;

  int activeShoppingLists;

  String csvExport;

  /// Returns a shallow copy of this [FamilyReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyReport copyWith({
    int? openTodos,
    int? completedTodos,
    double? totalExpenses,
    int? upcomingDeadlines,
    int? activeShoppingLists,
    String? csvExport,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'openTodos': openTodos,
      'completedTodos': completedTodos,
      'totalExpenses': totalExpenses,
      'upcomingDeadlines': upcomingDeadlines,
      'activeShoppingLists': activeShoppingLists,
      'csvExport': csvExport,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'openTodos': openTodos,
      'completedTodos': completedTodos,
      'totalExpenses': totalExpenses,
      'upcomingDeadlines': upcomingDeadlines,
      'activeShoppingLists': activeShoppingLists,
      'csvExport': csvExport,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FamilyReportImpl extends FamilyReport {
  _FamilyReportImpl({
    required int openTodos,
    required int completedTodos,
    required double totalExpenses,
    required int upcomingDeadlines,
    required int activeShoppingLists,
    required String csvExport,
  }) : super._(
          openTodos: openTodos,
          completedTodos: completedTodos,
          totalExpenses: totalExpenses,
          upcomingDeadlines: upcomingDeadlines,
          activeShoppingLists: activeShoppingLists,
          csvExport: csvExport,
        );

  /// Returns a shallow copy of this [FamilyReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyReport copyWith({
    int? openTodos,
    int? completedTodos,
    double? totalExpenses,
    int? upcomingDeadlines,
    int? activeShoppingLists,
    String? csvExport,
  }) {
    return FamilyReport(
      openTodos: openTodos ?? this.openTodos,
      completedTodos: completedTodos ?? this.completedTodos,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      upcomingDeadlines: upcomingDeadlines ?? this.upcomingDeadlines,
      activeShoppingLists: activeShoppingLists ?? this.activeShoppingLists,
      csvExport: csvExport ?? this.csvExport,
    );
  }
}
