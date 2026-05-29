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

/// Contatto emergenza familiare.
abstract class EmergencyContact
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  EmergencyContact._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.name,
    required this.phone,
    this.email,
    int? priority,
    this.notes,
  }) : priority = priority ?? 1;

  factory EmergencyContact({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required String phone,
    String? email,
    int? priority,
    String? notes,
  }) = _EmergencyContactImpl;

  factory EmergencyContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyContact(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      priority: jsonSerialization['priority'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = EmergencyContactTable();

  static const db = EmergencyContactRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String name;

  String phone;

  String? email;

  int priority;

  String? notes;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencyContact copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? name,
    String? phone,
    String? email,
    int? priority,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      'phone': phone,
      if (email != null) 'email': email,
      'priority': priority,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      'phone': phone,
      if (email != null) 'email': email,
      'priority': priority,
      if (notes != null) 'notes': notes,
    };
  }

  static EmergencyContactInclude include() {
    return EmergencyContactInclude._();
  }

  static EmergencyContactIncludeList includeList({
    _i1.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencyContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyContactTable>? orderByList,
    EmergencyContactInclude? include,
  }) {
    return EmergencyContactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencyContact.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EmergencyContact.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyContactImpl extends EmergencyContact {
  _EmergencyContactImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required String phone,
    String? email,
    int? priority,
    String? notes,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          name: name,
          phone: phone,
          email: email,
          priority: priority,
          notes: notes,
        );

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencyContact copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? name,
    String? phone,
    Object? email = _Undefined,
    int? priority,
    Object? notes = _Undefined,
  }) {
    return EmergencyContact(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      priority: priority ?? this.priority,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class EmergencyContactTable extends _i1.Table<int> {
  EmergencyContactTable({super.tableRelation})
      : super(tableName: 'emergency_contact') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
      hasDefault: true,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString name;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnString notes;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        name,
        phone,
        email,
        priority,
        notes,
      ];
}

class EmergencyContactInclude extends _i1.IncludeObject {
  EmergencyContactInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => EmergencyContact.t;
}

class EmergencyContactIncludeList extends _i1.IncludeList {
  EmergencyContactIncludeList._({
    _i1.WhereExpressionBuilder<EmergencyContactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmergencyContact.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => EmergencyContact.t;
}

class EmergencyContactRepository {
  const EmergencyContactRepository._();

  /// Returns a list of [EmergencyContact]s matching the given query parameters.
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
  Future<List<EmergencyContact>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencyContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EmergencyContact] matching the given query parameters.
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
  Future<EmergencyContact?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? offset,
    _i1.OrderByBuilder<EmergencyContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      orderBy: orderBy?.call(EmergencyContact.t),
      orderByList: orderByList?.call(EmergencyContact.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EmergencyContact] by its [id] or null if no such row exists.
  Future<EmergencyContact?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EmergencyContact>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EmergencyContact]s in the list and returns the inserted rows.
  ///
  /// The returned [EmergencyContact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EmergencyContact>> insert(
    _i1.Session session,
    List<EmergencyContact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EmergencyContact>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EmergencyContact] and returns the inserted row.
  ///
  /// The returned [EmergencyContact] will have its `id` field set.
  Future<EmergencyContact> insertRow(
    _i1.Session session,
    EmergencyContact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmergencyContact>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EmergencyContact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EmergencyContact>> update(
    _i1.Session session,
    List<EmergencyContact> rows, {
    _i1.ColumnSelections<EmergencyContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EmergencyContact>(
      rows,
      columns: columns?.call(EmergencyContact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmergencyContact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmergencyContact> updateRow(
    _i1.Session session,
    EmergencyContact row, {
    _i1.ColumnSelections<EmergencyContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmergencyContact>(
      row,
      columns: columns?.call(EmergencyContact.t),
      transaction: transaction,
    );
  }

  /// Deletes all [EmergencyContact]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EmergencyContact>> delete(
    _i1.Session session,
    List<EmergencyContact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EmergencyContact>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EmergencyContact].
  Future<EmergencyContact> deleteRow(
    _i1.Session session,
    EmergencyContact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmergencyContact>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EmergencyContact>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EmergencyContactTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EmergencyContact>(
      where: where(EmergencyContact.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyContactTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EmergencyContact>(
      where: where?.call(EmergencyContact.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
