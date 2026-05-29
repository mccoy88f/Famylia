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
import 'expense_category.dart' as _i2;
import 'expense_split_type.dart' as _i3;
import 'expense_status.dart' as _i4;

/// Spesa condivisa familiare.
abstract class Expense implements _i1.TableRow<int>, _i1.ProtocolSerialization {
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

  static final t = ExpenseTable();

  static const db = ExpenseRepository._();

  @override
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

  @override
  _i1.Table<int> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ExpenseInclude include() {
    return ExpenseInclude._();
  }

  static ExpenseIncludeList includeList({
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    ExpenseInclude? include,
  }) {
    return ExpenseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Expense.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Expense.t),
      include: include,
    );
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

class ExpenseTable extends _i1.Table<int> {
  ExpenseTable({super.tableRelation}) : super(tableName: 'expense') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    paidBy = _i1.ColumnInt(
      'paidBy',
      this,
    );
    splitType = _i1.ColumnEnum(
      'splitType',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    splitDetailsJson = _i1.ColumnString(
      'splitDetailsJson',
      this,
      hasDefault: true,
    );
    expenseDate = _i1.ColumnDateTime(
      'expenseDate',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnEnum<_i2.ExpenseCategory> category;

  late final _i1.ColumnInt paidBy;

  late final _i1.ColumnEnum<_i3.ExpenseSplitType> splitType;

  late final _i1.ColumnString splitDetailsJson;

  late final _i1.ColumnDateTime expenseDate;

  late final _i1.ColumnEnum<_i4.ExpenseStatus> status;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        title,
        description,
        amount,
        currency,
        category,
        paidBy,
        splitType,
        splitDetailsJson,
        expenseDate,
        status,
      ];
}

class ExpenseInclude extends _i1.IncludeObject {
  ExpenseInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => Expense.t;
}

class ExpenseIncludeList extends _i1.IncludeList {
  ExpenseIncludeList._({
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Expense.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Expense.t;
}

class ExpenseRepository {
  const ExpenseRepository._();

  /// Returns a list of [Expense]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Expense>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Expense>(
      where: where?.call(Expense.t),
      orderBy: orderBy?.call(Expense.t),
      orderByList: orderByList?.call(Expense.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Expense] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Expense?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExpenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Expense>(
      where: where?.call(Expense.t),
      orderBy: orderBy?.call(Expense.t),
      orderByList: orderByList?.call(Expense.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Expense] by its [id] or null if no such row exists.
  Future<Expense?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Expense>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Expense]s in the list and returns the inserted rows.
  ///
  /// The returned [Expense]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Expense>> insert(
    _i1.Session session,
    List<Expense> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Expense>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Expense] and returns the inserted row.
  ///
  /// The returned [Expense] will have its `id` field set.
  Future<Expense> insertRow(
    _i1.Session session,
    Expense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Expense>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Expense]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Expense>> update(
    _i1.Session session,
    List<Expense> rows, {
    _i1.ColumnSelections<ExpenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Expense>(
      rows,
      columns: columns?.call(Expense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Expense]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Expense> updateRow(
    _i1.Session session,
    Expense row, {
    _i1.ColumnSelections<ExpenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Expense>(
      row,
      columns: columns?.call(Expense.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Expense]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Expense>> delete(
    _i1.Session session,
    List<Expense> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Expense>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Expense].
  Future<Expense> deleteRow(
    _i1.Session session,
    Expense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Expense>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Expense>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExpenseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Expense>(
      where: where(Expense.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Expense>(
      where: where?.call(Expense.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
