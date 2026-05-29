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
import 'shopping_unit.dart' as _i2;
import 'shopping_category.dart' as _i3;

/// Articolo in lista spesa.
abstract class ShoppingItem
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  ShoppingItem._({
    this.id,
    required this.shoppingListId,
    required this.name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    this.checkedBy,
    this.checkedAt,
    this.priceEstimate,
    this.notes,
    required this.addedBy,
    bool? isUrgent,
  })  : quantity = quantity ?? 1.0,
        unit = unit ?? _i2.ShoppingUnit.pieces,
        category = category ?? _i3.ShoppingCategory.other,
        isChecked = isChecked ?? false,
        isUrgent = isUrgent ?? false;

  factory ShoppingItem({
    int? id,
    required int shoppingListId,
    required String name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    required int addedBy,
    bool? isUrgent,
  }) = _ShoppingItemImpl;

  factory ShoppingItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingItem(
      id: jsonSerialization['id'] as int?,
      shoppingListId: jsonSerialization['shoppingListId'] as int,
      name: jsonSerialization['name'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: _i2.ShoppingUnit.fromJson((jsonSerialization['unit'] as String)),
      category: _i3.ShoppingCategory.fromJson(
          (jsonSerialization['category'] as String)),
      isChecked: jsonSerialization['isChecked'] as bool,
      checkedBy: jsonSerialization['checkedBy'] as int?,
      checkedAt: jsonSerialization['checkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkedAt']),
      priceEstimate: (jsonSerialization['priceEstimate'] as num?)?.toDouble(),
      notes: jsonSerialization['notes'] as String?,
      addedBy: jsonSerialization['addedBy'] as int,
      isUrgent: jsonSerialization['isUrgent'] as bool,
    );
  }

  static final t = ShoppingItemTable();

  static const db = ShoppingItemRepository._();

  @override
  int? id;

  int shoppingListId;

  String name;

  double quantity;

  _i2.ShoppingUnit unit;

  _i3.ShoppingCategory category;

  bool isChecked;

  int? checkedBy;

  DateTime? checkedAt;

  double? priceEstimate;

  String? notes;

  int addedBy;

  bool isUrgent;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingItem copyWith({
    int? id,
    int? shoppingListId,
    String? name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    int? addedBy,
    bool? isUrgent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'shoppingListId': shoppingListId,
      'name': name,
      'quantity': quantity,
      'unit': unit.toJson(),
      'category': category.toJson(),
      'isChecked': isChecked,
      if (checkedBy != null) 'checkedBy': checkedBy,
      if (checkedAt != null) 'checkedAt': checkedAt?.toJson(),
      if (priceEstimate != null) 'priceEstimate': priceEstimate,
      if (notes != null) 'notes': notes,
      'addedBy': addedBy,
      'isUrgent': isUrgent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'shoppingListId': shoppingListId,
      'name': name,
      'quantity': quantity,
      'unit': unit.toJson(),
      'category': category.toJson(),
      'isChecked': isChecked,
      if (checkedBy != null) 'checkedBy': checkedBy,
      if (checkedAt != null) 'checkedAt': checkedAt?.toJson(),
      if (priceEstimate != null) 'priceEstimate': priceEstimate,
      if (notes != null) 'notes': notes,
      'addedBy': addedBy,
      'isUrgent': isUrgent,
    };
  }

  static ShoppingItemInclude include() {
    return ShoppingItemInclude._();
  }

  static ShoppingItemIncludeList includeList({
    _i1.WhereExpressionBuilder<ShoppingItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShoppingItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingItemTable>? orderByList,
    ShoppingItemInclude? include,
  }) {
    return ShoppingItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShoppingItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ShoppingItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShoppingItemImpl extends ShoppingItem {
  _ShoppingItemImpl({
    int? id,
    required int shoppingListId,
    required String name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    required int addedBy,
    bool? isUrgent,
  }) : super._(
          id: id,
          shoppingListId: shoppingListId,
          name: name,
          quantity: quantity,
          unit: unit,
          category: category,
          isChecked: isChecked,
          checkedBy: checkedBy,
          checkedAt: checkedAt,
          priceEstimate: priceEstimate,
          notes: notes,
          addedBy: addedBy,
          isUrgent: isUrgent,
        );

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingItem copyWith({
    Object? id = _Undefined,
    int? shoppingListId,
    String? name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    Object? checkedBy = _Undefined,
    Object? checkedAt = _Undefined,
    Object? priceEstimate = _Undefined,
    Object? notes = _Undefined,
    int? addedBy,
    bool? isUrgent,
  }) {
    return ShoppingItem(
      id: id is int? ? id : this.id,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      checkedBy: checkedBy is int? ? checkedBy : this.checkedBy,
      checkedAt: checkedAt is DateTime? ? checkedAt : this.checkedAt,
      priceEstimate:
          priceEstimate is double? ? priceEstimate : this.priceEstimate,
      notes: notes is String? ? notes : this.notes,
      addedBy: addedBy ?? this.addedBy,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}

class ShoppingItemTable extends _i1.Table<int> {
  ShoppingItemTable({super.tableRelation}) : super(tableName: 'shopping_item') {
    shoppingListId = _i1.ColumnInt(
      'shoppingListId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
      hasDefault: true,
    );
    unit = _i1.ColumnEnum(
      'unit',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    isChecked = _i1.ColumnBool(
      'isChecked',
      this,
      hasDefault: true,
    );
    checkedBy = _i1.ColumnInt(
      'checkedBy',
      this,
    );
    checkedAt = _i1.ColumnDateTime(
      'checkedAt',
      this,
    );
    priceEstimate = _i1.ColumnDouble(
      'priceEstimate',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    addedBy = _i1.ColumnInt(
      'addedBy',
      this,
    );
    isUrgent = _i1.ColumnBool(
      'isUrgent',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt shoppingListId;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnEnum<_i2.ShoppingUnit> unit;

  late final _i1.ColumnEnum<_i3.ShoppingCategory> category;

  late final _i1.ColumnBool isChecked;

  late final _i1.ColumnInt checkedBy;

  late final _i1.ColumnDateTime checkedAt;

  late final _i1.ColumnDouble priceEstimate;

  late final _i1.ColumnString notes;

  late final _i1.ColumnInt addedBy;

  late final _i1.ColumnBool isUrgent;

  @override
  List<_i1.Column> get columns => [
        id,
        shoppingListId,
        name,
        quantity,
        unit,
        category,
        isChecked,
        checkedBy,
        checkedAt,
        priceEstimate,
        notes,
        addedBy,
        isUrgent,
      ];
}

class ShoppingItemInclude extends _i1.IncludeObject {
  ShoppingItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => ShoppingItem.t;
}

class ShoppingItemIncludeList extends _i1.IncludeList {
  ShoppingItemIncludeList._({
    _i1.WhereExpressionBuilder<ShoppingItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShoppingItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => ShoppingItem.t;
}

class ShoppingItemRepository {
  const ShoppingItemRepository._();

  /// Returns a list of [ShoppingItem]s matching the given query parameters.
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
  Future<List<ShoppingItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShoppingItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ShoppingItem>(
      where: where?.call(ShoppingItem.t),
      orderBy: orderBy?.call(ShoppingItem.t),
      orderByList: orderByList?.call(ShoppingItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ShoppingItem] matching the given query parameters.
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
  Future<ShoppingItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<ShoppingItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ShoppingItem>(
      where: where?.call(ShoppingItem.t),
      orderBy: orderBy?.call(ShoppingItem.t),
      orderByList: orderByList?.call(ShoppingItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ShoppingItem] by its [id] or null if no such row exists.
  Future<ShoppingItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ShoppingItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ShoppingItem]s in the list and returns the inserted rows.
  ///
  /// The returned [ShoppingItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ShoppingItem>> insert(
    _i1.Session session,
    List<ShoppingItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ShoppingItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ShoppingItem] and returns the inserted row.
  ///
  /// The returned [ShoppingItem] will have its `id` field set.
  Future<ShoppingItem> insertRow(
    _i1.Session session,
    ShoppingItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShoppingItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ShoppingItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ShoppingItem>> update(
    _i1.Session session,
    List<ShoppingItem> rows, {
    _i1.ColumnSelections<ShoppingItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ShoppingItem>(
      rows,
      columns: columns?.call(ShoppingItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShoppingItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShoppingItem> updateRow(
    _i1.Session session,
    ShoppingItem row, {
    _i1.ColumnSelections<ShoppingItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShoppingItem>(
      row,
      columns: columns?.call(ShoppingItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ShoppingItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ShoppingItem>> delete(
    _i1.Session session,
    List<ShoppingItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ShoppingItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ShoppingItem].
  Future<ShoppingItem> deleteRow(
    _i1.Session session,
    ShoppingItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShoppingItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ShoppingItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ShoppingItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ShoppingItem>(
      where: where(ShoppingItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ShoppingItem>(
      where: where?.call(ShoppingItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
