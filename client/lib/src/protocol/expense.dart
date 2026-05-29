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
import 'expense_category.dart' as _i2;
import 'expense_split_type.dart' as _i3;
import 'expense_status.dart' as _i4;

/// Spesa condivisa familiare.
abstract class Expense implements _i1.SerializableModel {
  Expense._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.title,
    this.description,
    required this.amount,
    String? currency,
    _i2.ExpenseCategory? category,
    required this.paidBy,
    _i3.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    required this.expenseDate,
    _i4.ExpenseStatus? status,
  })  : currency = currency ?? 'EUR',
        category = category ?? _i2.ExpenseCategory.other,
        splitType = splitType ?? _i3.ExpenseSplitType.equal,
        splitDetailsJson = splitDetailsJson ?? '[]',
        status = status ?? _i4.ExpenseStatus.active;

  factory Expense({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    required double amount,
    String? currency,
    _i2.ExpenseCategory? category,
    required int paidBy,
    _i3.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    required DateTime expenseDate,
    _i4.ExpenseStatus? status,
  }) = _ExpenseImpl;

  factory Expense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Expense(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      category: _i2.ExpenseCategory.fromJson(
          (jsonSerialization['category'] as String)),
      paidBy: jsonSerialization['paidBy'] as int,
      splitType: _i3.ExpenseSplitType.fromJson(
          (jsonSerialization['splitType'] as String)),
      splitDetailsJson: jsonSerialization['splitDetailsJson'] as String,
      expenseDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expenseDate']),
      status:
          _i4.ExpenseStatus.fromJson((jsonSerialization['status'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  String title;

  String? description;

  double amount;

  String currency;

  _i2.ExpenseCategory category;

  int paidBy;

  _i3.ExpenseSplitType splitType;

  String splitDetailsJson;

  DateTime expenseDate;

  _i4.ExpenseStatus status;

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Expense copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? description,
    double? amount,
    String? currency,
    _i2.ExpenseCategory? category,
    int? paidBy,
    _i3.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    DateTime? expenseDate,
    _i4.ExpenseStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'title': title,
      if (description != null) 'description': description,
      'amount': amount,
      'currency': currency,
      'category': category.toJson(),
      'paidBy': paidBy,
      'splitType': splitType.toJson(),
      'splitDetailsJson': splitDetailsJson,
      'expenseDate': expenseDate.toJson(),
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseImpl extends Expense {
  _ExpenseImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    required double amount,
    String? currency,
    _i2.ExpenseCategory? category,
    required int paidBy,
    _i3.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    required DateTime expenseDate,
    _i4.ExpenseStatus? status,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          description: description,
          amount: amount,
          currency: currency,
          category: category,
          paidBy: paidBy,
          splitType: splitType,
          splitDetailsJson: splitDetailsJson,
          expenseDate: expenseDate,
          status: status,
        );

  /// Returns a shallow copy of this [Expense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Expense copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? title,
    Object? description = _Undefined,
    double? amount,
    String? currency,
    _i2.ExpenseCategory? category,
    int? paidBy,
    _i3.ExpenseSplitType? splitType,
    String? splitDetailsJson,
    DateTime? expenseDate,
    _i4.ExpenseStatus? status,
  }) {
    return Expense(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      paidBy: paidBy ?? this.paidBy,
      splitType: splitType ?? this.splitType,
      splitDetailsJson: splitDetailsJson ?? this.splitDetailsJson,
      expenseDate: expenseDate ?? this.expenseDate,
      status: status ?? this.status,
    );
  }
}
