import 'package:json_annotation/json_annotation.dart';

part 'surah_harian_model.g.dart';

@JsonSerializable()
class SurahHarianModel {
  String id, doa, ayat, latin, artinya;

  SurahHarianModel({
    required this.id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  factory SurahHarianModel.fromJson(Map<String, dynamic> json) =>
      _$SurahHarianModelFromJson(json);

  /// Connect the generated [_$SurahHarianModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurahHarianModelToJson(this);
}
