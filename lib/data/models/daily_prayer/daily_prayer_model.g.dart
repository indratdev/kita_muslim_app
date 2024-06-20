// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_prayer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyPrayerModel _$DailyPrayerModelFromJson(Map<String, dynamic> json) =>
    DailyPrayerModel(
      id: json['id'] as String,
      id_id: json['id_id'] as String?,
      doa: json['doa'] as String,
      ayat: json['ayat'] as String,
      latin: json['latin'] as String,
      artinya: json['artinya'] as String,
    );

Map<String, dynamic> _$DailyPrayerModelToJson(DailyPrayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_id': instance.id_id,
      'doa': instance.doa,
      'ayat': instance.ayat,
      'latin': instance.latin,
      'artinya': instance.artinya,
    };
