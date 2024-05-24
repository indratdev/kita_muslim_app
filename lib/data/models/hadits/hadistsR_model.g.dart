// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadistsR_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadistsRModel _$HadistsRModelFromJson(Map<String, dynamic> json) =>
    HadistsRModel(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as bool? ?? false,
    );

Map<String, dynamic> _$HadistsRModelToJson(HadistsRModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String,
      id: json['id'] as String,
      available: json['available'] as int? ?? 0,
      contents: ContentsR.fromJson(json['contents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'available': instance.available,
      'contents': instance.contents,
    };

ContentsR _$ContentsRFromJson(Map<String, dynamic> json) => ContentsR(
      number: json['number'] as int? ?? 0,
      arab: json['arab'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ContentsRToJson(ContentsR instance) => <String, dynamic>{
      'number': instance.number,
      'arab': instance.arab,
      'id': instance.id,
    };
