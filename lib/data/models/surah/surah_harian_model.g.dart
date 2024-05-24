// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_harian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahHarianModel _$SurahHarianModelFromJson(Map<String, dynamic> json) =>
    SurahHarianModel(
      id: json['id'] as String,
      doa: json['doa'] as String,
      ayat: json['ayat'] as String,
      latin: json['latin'] as String,
      artinya: json['artinya'] as String,
    );

Map<String, dynamic> _$SurahHarianModelToJson(SurahHarianModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doa': instance.doa,
      'ayat': instance.ayat,
      'latin': instance.latin,
      'artinya': instance.artinya,
    };
