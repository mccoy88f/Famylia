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
import 'ai_provider.dart' as _i2;

/// Configurazione AI globale (singleton).
abstract class AiConfig implements _i1.SerializableModel {
  AiConfig._({
    this.id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required this.updatedAt,
  })  : provider = provider ?? _i2.AiProvider.openrouter,
        modelName = modelName ?? 'google/gemini-flash-1.5',
        systemPrompt = systemPrompt ??
            'Sei MarIA, l\'assistente familiare di Famylia. Analizza il contenuto e rispondi SOLO con JSON valido.';

  factory AiConfig({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required DateTime updatedAt,
  }) = _AiConfigImpl;

  factory AiConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConfig(
      id: jsonSerialization['id'] as int?,
      provider: _i2.AiProvider.fromJson(
          (jsonSerialization['provider'] as String)),
      modelName: jsonSerialization['modelName'] as String,
      systemPrompt: jsonSerialization['systemPrompt'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  int? id;

  _i2.AiProvider provider;

  String modelName;

  String systemPrompt;

  DateTime updatedAt;

  @_i1.useResult
  AiConfig copyWith({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'provider': provider.toJson(),
      'modelName': modelName,
      'systemPrompt': systemPrompt,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiConfigImpl extends AiConfig {
  _AiConfigImpl({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          provider: provider,
          modelName: modelName,
          systemPrompt: systemPrompt,
          updatedAt: updatedAt,
        );

  @_i1.useResult
  @override
  AiConfig copyWith({
    Object? id = _Undefined,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    DateTime? updatedAt,
  }) {
    return AiConfig(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      modelName: modelName ?? this.modelName,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
