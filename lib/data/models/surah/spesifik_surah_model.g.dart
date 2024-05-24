// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spesifik_surah_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpesifikSurahModel _$SpesifikSurahModelFromJson(Map<String, dynamic> json) =>
    SpesifikSurahModel(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpesifikSurahModelToJson(SpesifikSurahModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      number: json['number'] as int? ?? 0,
      numberOfVerses: json['numberOfVerses'] as int? ?? 0,
      revelation:
          Revelation.fromJson(json['revelation'] as Map<String, dynamic>),
      sequence: json['sequence'] as int? ?? 0,
      tafsir: Tafsir.fromJson(json['tafsir'] as Map<String, dynamic>),
      verses: (json['verses'] as List<dynamic>)
          .map((e) => Verses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'number': instance.number,
      'sequence': instance.sequence,
      'numberOfVerses': instance.numberOfVerses,
      'name': instance.name,
      'revelation': instance.revelation,
      'tafsir': instance.tafsir,
      'verses': instance.verses,
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
      arab: json['arab'] as String? ?? '',
      en: json['en'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$RevelationToJson(Revelation instance) =>
    <String, dynamic>{
      'arab': instance.arab,
      'en': instance.en,
      'id': instance.id,
    };

Tafsir _$TafsirFromJson(Map<String, dynamic> json) => Tafsir(
      id: json['id'] as String?,
    )..en = json['en'] as String?;

Map<String, dynamic> _$TafsirToJson(Tafsir instance) => <String, dynamic>{
      'id': instance.id,
      'en': instance.en,
    };

Verses _$VersesFromJson(Map<String, dynamic> json) => Verses(
      number: Number.fromJson(json['number'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      text: Text.fromJson(json['text'] as Map<String, dynamic>),
      translation:
          Translation.fromJson(json['translation'] as Map<String, dynamic>),
      audio: Audio.fromJson(json['audio'] as Map<String, dynamic>),
      tafsir: TafsirB.fromJson(json['tafsir'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VersesToJson(Verses instance) => <String, dynamic>{
      'number': instance.number,
      'meta': instance.meta,
      'text': instance.text,
      'translation': instance.translation,
      'audio': instance.audio,
      'tafsir': instance.tafsir,
    };

Number _$NumberFromJson(Map<String, dynamic> json) => Number(
      inQuran: json['inQuran'] as int? ?? 0,
      inSurah: json['inSurah'] as int? ?? 0,
    );

Map<String, dynamic> _$NumberToJson(Number instance) => <String, dynamic>{
      'inQuran': instance.inQuran,
      'inSurah': instance.inSurah,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      juz: json['juz'] as int? ?? 0,
      page: json['page'] as int? ?? 0,
      manzil: json['manzil'] as int? ?? 0,
      ruku: json['ruku'] as int? ?? 0,
      hizbQuarter: json['hizbQuarter'] as int? ?? 0,
      sajda: Sajda.fromJson(json['sajda'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'juz': instance.juz,
      'page': instance.page,
      'manzil': instance.manzil,
      'ruku': instance.ruku,
      'hizbQuarter': instance.hizbQuarter,
      'sajda': instance.sajda,
    };

Sajda _$SajdaFromJson(Map<String, dynamic> json) => Sajda(
      obligatory: json['obligatory'] as bool? ?? false,
      recommended: json['recommended'] as bool? ?? false,
    );

Map<String, dynamic> _$SajdaToJson(Sajda instance) => <String, dynamic>{
      'recommended': instance.recommended,
      'obligatory': instance.obligatory,
    };

Text _$TextFromJson(Map<String, dynamic> json) => Text(
      arab: json['arab'] as String? ?? '',
      transliteration: Transliteration.fromJson(
          json['transliteration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TextToJson(Text instance) => <String, dynamic>{
      'arab': instance.arab,
      'transliteration': instance.transliteration,
    };

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
      primary: json['primary'] as String? ?? '',
      secondary:
          (json['secondary'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
      'primary': instance.primary,
      'secondary': instance.secondary,
    };

TafsirB _$TafsirBFromJson(Map<String, dynamic> json) => TafsirB(
      id: json['id'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$TafsirBToJson(TafsirB instance) => <String, dynamic>{
      'id': instance.id,
    };
