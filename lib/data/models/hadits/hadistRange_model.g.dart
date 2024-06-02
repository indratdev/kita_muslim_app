// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadistRange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HadistRangeModel _$HadistRangeModelFromJson(Map<String, dynamic> json) =>
    HadistRangeModel(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as bool,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HadistRangeModelToJson(HadistRangeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String,
      id: json['id'] as String,
      available: (json['available'] as num).toInt(),
      requested: (json['requested'] as num).toInt(),
      hadiths: (json['hadiths'] as List<dynamic>)
          .map((e) => Hadiths.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'available': instance.available,
      'requested': instance.requested,
      'hadiths': instance.hadiths,
    };

Hadiths _$HadithsFromJson(Map<String, dynamic> json) => Hadiths(
      number: (json['number'] as num).toInt(),
      arab: json['arab'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$HadithsToJson(Hadiths instance) => <String, dynamic>{
      'number': instance.number,
      'arab': instance.arab,
      'id': instance.id,
    };
