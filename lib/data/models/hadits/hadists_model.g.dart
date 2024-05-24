// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadists_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadistsModel _$HadistsModelFromJson(Map<String, dynamic> json) => HadistsModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataBooksHadists.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool? ?? false,
    );

Map<String, dynamic> _$HadistsModelToJson(HadistsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

DataBooksHadists _$DataBooksHadistsFromJson(Map<String, dynamic> json) =>
    DataBooksHadists(
      name: json['name'] as String,
      id: json['id'] as String,
      available: json['available'] as int,
    );

Map<String, dynamic> _$DataBooksHadistsToJson(DataBooksHadists instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'available': instance.available,
    };
