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
import 'settlement_status.dart' as _i2;

/// Registrazione saldo tra membri.
abstract class Settlement implements _i1.SerializableModel {
  Settlement._({
    this.id,
    required this.familyId,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    String? currency,
    _i2.SettlementStatus? status,
    this.settledAt,
  })  : currency = currency ?? 'EUR',
        status = status ?? _i2.SettlementStatus.pending;

  factory Settlement({
    int? id,
    required int familyId,
    required int fromUserId,
    required int toUserId,
    required double amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  }) = _SettlementImpl;

  factory Settlement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Settlement(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      fromUserId: jsonSerialization['fromUserId'] as int,
      toUserId: jsonSerialization['toUserId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      status: _i2.SettlementStatus.fromJson(
          (jsonSerialization['status'] as String)),
      settledAt: jsonSerialization['settledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['settledAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int fromUserId;

  int toUserId;

  double amount;

  String currency;

  _i2.SettlementStatus status;

  DateTime? settledAt;

  /// Returns a shallow copy of this [Settlement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Settlement copyWith({
    int? id,
    int? familyId,
    int? fromUserId,
    int? toUserId,
    double? amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'amount': amount,
      'currency': currency,
      'status': status.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SettlementImpl extends Settlement {
  _SettlementImpl({
    int? id,
    required int familyId,
    required int fromUserId,
    required int toUserId,
    required double amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  }) : super._(
          id: id,
          familyId: familyId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          amount: amount,
          currency: currency,
          status: status,
          settledAt: settledAt,
        );

  /// Returns a shallow copy of this [Settlement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Settlement copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? fromUserId,
    int? toUserId,
    double? amount,
    String? currency,
    _i2.SettlementStatus? status,
    Object? settledAt = _Undefined,
  }) {
    return Settlement(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      settledAt: settledAt is DateTime? ? settledAt : this.settledAt,
    );
  }
}
