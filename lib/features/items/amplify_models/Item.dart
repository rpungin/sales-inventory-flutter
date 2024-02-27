/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Item type in your schema. */
class Item extends amplify_core.Model {
  static const classType = const _ItemModelType();
  final String id;
  final String? _name;
  final String? _description;
  final double? _price;
  final int? _initialQuantity;
  final int? _remainingQuantity;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ItemModelIdentifier get modelIdentifier {
      return ItemModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get description {
    return _description;
  }
  
  double get price {
    try {
      return _price!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get initialQuantity {
    try {
      return _initialQuantity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get remainingQuantity {
    try {
      return _remainingQuantity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Item._internal({required this.id, required name, description, required price, required initialQuantity, required remainingQuantity, createdAt, updatedAt}): _name = name, _description = description, _price = price, _initialQuantity = initialQuantity, _remainingQuantity = remainingQuantity, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Item({String? id, required String name, String? description, required double price, required int initialQuantity, required int remainingQuantity}) {
    return Item._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      description: description,
      price: price,
      initialQuantity: initialQuantity,
      remainingQuantity: remainingQuantity);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _price == other._price &&
      _initialQuantity == other._initialQuantity &&
      _remainingQuantity == other._remainingQuantity;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Item {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("price=" + (_price != null ? _price.toString() : "null") + ", ");
    buffer.write("initialQuantity=" + (_initialQuantity != null ? _initialQuantity.toString() : "null") + ", ");
    buffer.write("remainingQuantity=" + (_remainingQuantity != null ? _remainingQuantity.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Item copyWith({String? name, String? description, double? price, int? initialQuantity, int? remainingQuantity}) {
    return Item._internal(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity);
  }
  
  Item copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? description,
    ModelFieldValue<double>? price,
    ModelFieldValue<int>? initialQuantity,
    ModelFieldValue<int>? remainingQuantity
  }) {
    return Item._internal(
      id: id,
      name: name == null ? this.name : name.value,
      description: description == null ? this.description : description.value,
      price: price == null ? this.price : price.value,
      initialQuantity: initialQuantity == null ? this.initialQuantity : initialQuantity.value,
      remainingQuantity: remainingQuantity == null ? this.remainingQuantity : remainingQuantity.value
    );
  }
  
  Item.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _price = (json['price'] as num?)?.toDouble(),
      _initialQuantity = (json['initialQuantity'] as num?)?.toInt(),
      _remainingQuantity = (json['remainingQuantity'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'price': _price, 'initialQuantity': _initialQuantity, 'remainingQuantity': _remainingQuantity, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'description': _description,
    'price': _price,
    'initialQuantity': _initialQuantity,
    'remainingQuantity': _remainingQuantity,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ItemModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ItemModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final PRICE = amplify_core.QueryField(fieldName: "price");
  static final INITIALQUANTITY = amplify_core.QueryField(fieldName: "initialQuantity");
  static final REMAININGQUANTITY = amplify_core.QueryField(fieldName: "remainingQuantity");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Item";
    modelSchemaDefinition.pluralName = "Items";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.DESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.PRICE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.INITIALQUANTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Item.REMAININGQUANTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ItemModelType extends amplify_core.ModelType<Item> {
  const _ItemModelType();
  
  @override
  Item fromJson(Map<String, dynamic> jsonData) {
    return Item.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Item';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Item] in your schema.
 */
class ItemModelIdentifier implements amplify_core.ModelIdentifier<Item> {
  final String id;

  /** Create an instance of ItemModelIdentifier using [id] the primary key. */
  const ItemModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'ItemModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ItemModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}