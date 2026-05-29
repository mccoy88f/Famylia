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
import 'member_balance.dart' as _i2;
import 'settlement_suggestion.dart' as _i3;

/// Bilancio spese famiglia.
abstract class FamilyBalance
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FamilyBalance._({
    required this.members,
    required this.suggestions,
  });

  factory FamilyBalance({
    required List<_i2.MemberBalance> members,
    required List<_i3.SettlementSuggestion> suggestions,
  }) = _FamilyBalanceImpl;

  factory FamilyBalance.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyBalance(
      members: (jsonSerialization['members'] as List)
          .map((e) => _i2.MemberBalance.fromJson((e as Map<String, dynamic>)))
          .toList(),
      suggestions: (jsonSerialization['suggestions'] as List)
          .map((e) =>
              _i3.SettlementSuggestion.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  List<_i2.MemberBalance> members;

  List<_i3.SettlementSuggestion> suggestions;

  /// Returns a shallow copy of this [FamilyBalance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyBalance copyWith({
    List<_i2.MemberBalance>? members,
    List<_i3.SettlementSuggestion>? suggestions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'members': members.toJson(valueToJson: (v) => v.toJson()),
      'suggestions': suggestions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'members': members.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'suggestions':
          suggestions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FamilyBalanceImpl extends FamilyBalance {
  _FamilyBalanceImpl({
    required List<_i2.MemberBalance> members,
    required List<_i3.SettlementSuggestion> suggestions,
  }) : super._(
          members: members,
          suggestions: suggestions,
        );

  /// Returns a shallow copy of this [FamilyBalance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyBalance copyWith({
    List<_i2.MemberBalance>? members,
    List<_i3.SettlementSuggestion>? suggestions,
  }) {
    return FamilyBalance(
      members: members ?? this.members.map((e0) => e0.copyWith()).toList(),
      suggestions:
          suggestions ?? this.suggestions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
