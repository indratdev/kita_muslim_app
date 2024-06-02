import 'package:json_annotation/json_annotation.dart';

part 'spesifik_surah_model.g.dart';

@JsonSerializable()
class SpesifikSurahModel {
  int code;
  String status, message;
  Data data;

  SpesifikSurahModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpesifikSurahModel.fromJson(Map<String, dynamic> json) =>
      _$SpesifikSurahModelFromJson(json);

  /// Connect the generated [_$SpesifikSurahModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SpesifikSurahModelToJson(this);
}

@JsonSerializable()
class Data {
  int number, sequence, numberOfVerses;
  Name name;
  Revelation revelation;
  Tafsir tafsir;
  PreBismillah? preBismillah;
  List<Verses> verses;

  Data({
    required this.name,
    this.number = 0,
    this.numberOfVerses = 0,
    this.preBismillah,
    required this.revelation,
    this.sequence = 0,
    required this.tafsir,
    required this.verses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Name {
  String short, long;
  Transliteration transliteration;
  Translation translation;

  Name({
    this.short = '',
    this.long = '',
    required this.transliteration,
    required this.translation,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class Transliteration {
  String en, id;

  Transliteration({
    this.en = '',
    this.id = '',
  });

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      _$TransliterationFromJson(json);

  Map<String, dynamic> toJson() => _$TransliterationToJson(this);
}

@JsonSerializable()
class Translation {
  String en, id;

  Translation({
    this.en = '',
    this.id = '',
  });

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}

@JsonSerializable()
class Revelation {
  String arab, en, id;

  Revelation({
    this.arab = '',
    this.en = '',
    this.id = '',
  });

  factory Revelation.fromJson(Map<String, dynamic> json) =>
      _$RevelationFromJson(json);

  Map<String, dynamic> toJson() => _$RevelationToJson(this);
}

@JsonSerializable()
class Tafsir {
  String? id, en;

  Tafsir({
    this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => _$TafsirFromJson(json);

  Map<String, dynamic> toJson() => _$TafsirToJson(this);
}

@JsonSerializable()
class PreBismillah {
  TextPre? text;
  TranslationPre? translation;
  AudioPre? audio;


  PreBismillah({
    this.text,
    this.audio,
    this.translation,
  });

  factory PreBismillah.fromJson(Map<String, dynamic> json) => _$PreBismillahFromJson(json);

  Map<String, dynamic> toJson() => _$PreBismillahToJson(this);
}


@JsonSerializable()
class TextPre {
  String? arab;
  TransliterationPre? transliteration;


 TextPre({
    this.arab,
    this.transliteration,
  });

  factory TextPre.fromJson(Map<String, dynamic> json) => _$TextPreFromJson(json);

  Map<String, dynamic> toJson() => _$TextPreToJson(this);

}

@JsonSerializable()
class TransliterationPre {
  String? en;


 TransliterationPre({
    this.en,
  });

  factory TransliterationPre.fromJson(Map<String, dynamic> json) => _$TransliterationPreFromJson(json);
  Map<String, dynamic> toJson() => _$TransliterationPreToJson(this);

}


@JsonSerializable()
class TranslationPre {
  String en, id;

  TranslationPre({
    this.en = '',
    this.id = '',
  });

  factory TranslationPre.fromJson(Map<String, dynamic> json) =>
      _$TranslationPreFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationPreToJson(this);
}

@JsonSerializable()
class AudioPre {
  String? primary;
  List<String>? secondary;

  AudioPre({
    this.primary = '',
    required this.secondary,
  });

  factory AudioPre.fromJson(Map<String, dynamic> json) => _$AudioPreFromJson(json);

  Map<String, dynamic> toJson() => _$AudioPreToJson(this);
}


@JsonSerializable()
class Verses {
  Number number;
  Meta meta;
  Text text;
  Translation translation;
  Audio audio;
  TafsirB tafsir;

  Verses({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
    required this.tafsir,
  });

  factory Verses.fromJson(Map<String, dynamic> json) => _$VersesFromJson(json);

  Map<String, dynamic> toJson() => _$VersesToJson(this);
}

@JsonSerializable()
class Number {
  int inQuran, inSurah;

  Number({
    this.inQuran = 0,
    this.inSurah = 0,
  });

  factory Number.fromJson(Map<String, dynamic> json) => _$NumberFromJson(json);

  Map<String, dynamic> toJson() => _$NumberToJson(this);
}

@JsonSerializable()
class Meta {
  int juz, page, manzil, ruku, hizbQuarter;
  Sajda sajda;

  Meta({
    this.juz = 0,
    this.page = 0,
    this.manzil = 0,
    this.ruku = 0,
    this.hizbQuarter = 0,
    required this.sajda,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Sajda {
  bool recommended, obligatory;

  Sajda({
    this.obligatory = false,
    this.recommended = false,
  });

  factory Sajda.fromJson(Map<String, dynamic> json) => _$SajdaFromJson(json);

  Map<String, dynamic> toJson() => _$SajdaToJson(this);
}

@JsonSerializable()
class Text {
  String arab;
  Transliteration transliteration;

  Text({
    this.arab = '',
    required this.transliteration,
  });

  factory Text.fromJson(Map<String, dynamic> json) => _$TextFromJson(json);

  Map<String, dynamic> toJson() => _$TextToJson(this);
}

@JsonSerializable()
class Audio {
  String primary;
  List<String> secondary;

  Audio({
    this.primary = '',
    required this.secondary,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);

  Map<String, dynamic> toJson() => _$AudioToJson(this);
}

@JsonSerializable()
class TafsirB {
  Map<String, dynamic> id;

  TafsirB({
    required this.id,
  });

  factory TafsirB.fromJson(Map<String, dynamic> json) =>
      _$TafsirBFromJson(json);

  Map<String, dynamic> toJson() => _$TafsirBToJson(this);
}
