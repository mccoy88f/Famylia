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

/// Suggerimento transazione per saldare debiti.
abstract class SettlementSuggestion implements _i1.SerializableModel {
  SettlementSuggestion._({
    required this.fromUserId,
    required this.fromDisplayName,
    required this.toUserId,
    required this.toDisplayName,
    required this.amount,
  });

  factory SettlementSuggestion({
    required int fromUserId,
    required String fromDisplayName,
    required int toUserId,
    required String toDisplayName,
    required double amount,
  }) = _SettlementSuggestionImpl;

  factory SettlementSuggestion.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SettlementSuggestion(
      fromUserId: jsonSerialization['fromUserId'] as int,
      fromDisplayName: jsonSerialization['fromDisplayName'] as String,
      toUserId: jsonSerialization['toUserId'] as int,
      toDisplayName: jsonSerialization['toDisplayName'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
    );
  }

  int fromUserId;

  String fromDisplayName;

  int toUserId;

  String toDisplayName;

  double amount;

  /// Returns a shallow copy of this [SettlementSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SettlementSuggestion copyWith({
    int? fromUserId,
    String? fromDisplayName,
    int? toUserId,
    String? toDisplayName,
    double? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'fromUserId': fromUserId,
      'fromDisplayName': fromDisplayName,
      'toUserId': toUserId,
      'toDisplayName': toDisplayName,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SettlementSuggestionImpl extends SettlementSuggestion {
  _SettlementSuggestionImpl({
    required int fromUserId,
    required String fromDisplayName,
    required int toUserId,
    required String toDisplayName,
    required double amount,
  }) : super._(
          fromUserId: fromUserId,
          fromDisplayName: fromDisplayName,
          toUserId: toUserId,
          toDisplayName: toDisplayName,
          amount: amount,
        );

  /// Returns a shallow copy of this [SettlementSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SettlementSuggestion copyWith({
    int? fromUserId,
    String? fromDisplayName,
    int? toUserId,
    String? toDisplayName,
    double? amount,
  }) {
    return SettlementSuggestion(
      fromUserId: fromUserId ?? this.fromUserId,
      fromDisplayName: fromDisplayName ?? this.fromDisplayName,
      toUserId: toUserId ?? this.toUserId,
      toDisplayName: toDisplayName ?? this.toDisplayName,
      amount: amount ?? this.amount,
    );
  }
}
