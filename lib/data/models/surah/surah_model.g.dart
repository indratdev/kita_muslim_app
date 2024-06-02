// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurahModel _$SurahModelFromJson(Map<String, dynamic> json) => SurahModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$SurahModelToJson(SurahModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      number: (json['number'] as num?)?.toInt() ?? 0,
      sequence: (json['sequence'] as num?)?.toInt() ?? 0,
      numberOfVerses: (json['numberOfVerses'] as num?)?.toInt() ?? 0,
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      revelation:
          Revelation.fromJson(json['revelation'] as Map<String, dynamic>),
      tafsir: Tafsir.fromJson(json['tafsir'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'number': instance.number,
      'sequence': instance.sequence,
      'numberOfVerses': instance.numberOfVerses,
      'name': instance.name,
      'revelation': instance.revelation,
      'tafsir': instance.tafsir,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      short: json['short'] as String? ?? '',
      long: json['long'] as String? ?? '',
      transliteration: Transliteration.fromJson(
          json['transliteration'] as Map<String, dynamic>),
      translation:
          Translation.fromJson(json['translation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'short': instance.short,
      'long': instance.long,
      'transliteration': instance.transliteration,
      'translation': instance.translation,
    };

Transliteration _$TransliterationFromJson(Map<String, dynamic> json) =>
    Transliteration(
      en: json['en'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$TransliterationToJson(Transliteration instance) =>
    <String, dynamic>{
      'en': instance.en,
      'id': instance.id,
    };

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      en: json['en'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'en': instance.en,
      'id': instance.id,
    };

Revelation _$RevelationFromJson(Map<String, dynamic> json) => Revelation(
      en: json['en'] as String? ?? '',
      id: json['id'] as String? ?? '',
      arab: json['arab'] as String? ?? '',
    );

Map<String, dynamic> _$RevelationToJson(Revelation instance) =>
    <String, dynamic>{
      'arab': instance.arab,
      'en': instance.en,
      'id': instance.id,
    };

Tafsir _$TafsirFromJson(Map<String, dynamic> json) => Tafsir(
      id: json['id'] as String,
    );

Map<String, dynamic> _$TafsirToJson(Tafsir instance) => <String, dynamic>{
      'id': instance.id,
    };
