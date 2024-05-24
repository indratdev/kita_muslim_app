import 'package:json_annotation/json_annotation.dart';

part 'surah_model.g.dart';

@JsonSerializable()
class SurahModel {
  int code;
  String status, message;
  List<Data> data;

  SurahModel({
    required this.data,
    required this.code,
    required this.message,
    required this.status,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) =>
      _$SurahModelFromJson(json);

  /// Connect the generated [_$SurahModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurahModelToJson(this);
}

@JsonSerializable()
class Data {
  int number, sequence, numberOfVerses;
  Name name;
  Revelation revelation;
  Tafsir tafsir;

  Data({
    this.number = 0,
    this.sequence = 0,
    this.numberOfVerses = 0,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  /// Connect the generated [_$DataToJson] function to the `toJson` method.
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

  /// Connect the generated [_$NameToJson] function to the `toJson` method.
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

  /// Connect the generated [_$TransliterationToJson] function to the `toJson` method.
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

  /// Connect the generated [_$TranslationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TranslationToJson(this);
}

@JsonSerializable()
class Revelation {
  String arab, en, id;

  Revelation({
    this.en = '',
    this.id = '',
    this.arab = '',
  });

  factory Revelation.fromJson(Map<String, dynamic> json) =>
      _$RevelationFromJson(json);

  /// Connect the generated [_$RevelationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RevelationToJson(this);
}

@JsonSerializable()
class Tafsir {
  String id;

  Tafsir({required this.id});

  factory Tafsir.fromJson(Map<String, dynamic> json) => _$TafsirFromJson(json);

  /// Connect the generated [_$TafsirToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TafsirToJson(this);
}
