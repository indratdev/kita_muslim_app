import 'package:json_annotation/json_annotation.dart';

part 'surah_local_model.g.dart';

@JsonSerializable()
class SurahLocalModel {
  int? id;
  String? number,
      sequence,
      number_of_verses,
      name_short,
      name_long,
      transliteration_en,
      transliteration_id,
      translation_en,
      translation_id,
      revelation_arab,
      revelation_en,
      revelation_id,
      tafsir;

  SurahLocalModel({
    this.id,
    this.number,
    this.sequence,
    this.number_of_verses,
    this.name_short,
    this.name_long,
    this.transliteration_en,
    this.transliteration_id,
    this.translation_en,
    this.translation_id,
    this.revelation_arab,
    this.revelation_en,
    this.revelation_id,
    this.tafsir,
  });

  factory SurahLocalModel.fromJson(Map<String, dynamic> json) =>
      _$SurahLocalModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurahLocalModelToJson(this);
}
