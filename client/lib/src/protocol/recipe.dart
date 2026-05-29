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

/// Ricetta familiare.
abstract class Recipe implements _i1.SerializableModel {
  Recipe._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.title,
    this.description,
    String? ingredientsJson,
    int? servings,
  })  : ingredientsJson = ingredientsJson ?? '[]',
        servings = servings ?? 4;

  factory Recipe({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    String? ingredientsJson,
    int? servings,
  }) = _RecipeImpl;

  factory Recipe.fromJson(Map<String, dynamic> jsonSerialization) {
    return Recipe(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      ingredientsJson: jsonSerialization['ingredientsJson'] as String,
      servings: jsonSerialization['servings'] as int,
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

  String ingredientsJson;

  int servings;

  /// Returns a shallow copy of this [Recipe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Recipe copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? description,
    String? ingredientsJson,
    int? servings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'title': title,
      if (description != null) 'description': description,
      'ingredientsJson': ingredientsJson,
      'servings': servings,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecipeImpl extends Recipe {
  _RecipeImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    String? ingredientsJson,
    int? servings,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          description: description,
          ingredientsJson: ingredientsJson,
          servings: servings,
        );

  /// Returns a shallow copy of this [Recipe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Recipe copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? title,
    Object? description = _Undefined,
    String? ingredientsJson,
    int? servings,
  }) {
    return Recipe(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      ingredientsJson: ingredientsJson ?? this.ingredientsJson,
      servings: servings ?? this.servings,
    );
  }
}
