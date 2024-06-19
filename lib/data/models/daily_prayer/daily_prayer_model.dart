import 'package:json_annotation/json_annotation.dart';

part 'daily_prayer_model.g.dart';

@JsonSerializable()
class DailyPrayerModel {
  String id;
  String doa;
  String ayat;
  String latin;
  String artinya;

  DailyPrayerModel({
    required this.id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  factory DailyPrayerModel.fromJson(Map<String, dynamic> json) =>
      _$DailyPrayerModelFromJson(json);

  /// Connect the generated [_$DailyPrayerModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DailyPrayerModelToJson(this);
}
