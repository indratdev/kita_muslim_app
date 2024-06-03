// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahLocalModel _$SurahLocalModelFromJson(Map<String, dynamic> json) =>
    SurahLocalModel(
      id: (json['id'] as num?)?.toInt(),
      number: json['number'] as String?,
      sequence: json['sequence'] as String?,
      number_of_verses: json['number_of_verses'] as String?,
      name_short: json['name_short'] as String?,
      name_long: json['name_long'] as String?,
      transliteration_en: json['transliteration_en'] as String?,
      transliteration_id: json['transliteration_id'] as String?,
      translation_en: json['translation_en'] as String?,
      translation_id: json['translation_id'] as String?,
      revelation_arab: json['revelation_arab'] as String?,
      revelation_en: json['revelation_en'] as String?,
      revelation_id: json['revelation_id'] as String?,
      tafsir: json['tafsir'] as String?,
    );

Map<String, dynamic> _$SurahLocalModelToJson(SurahLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'sequence': instance.sequence,
      'number_of_verses': instance.number_of_verses,
      'name_short': instance.name_short,
      'name_long': instance.name_long,
      'transliteration_en': instance.transliteration_en,
      'transliteration_id': instance.transliteration_id,
      'translation_en': instance.translation_en,
      'translation_id': instance.translation_id,
      'revelation_arab': instance.revelation_arab,
      'revelation_en': instance.revelation_en,
      'revelation_id': instance.revelation_id,
      'tafsir': instance.tafsir,
    };
