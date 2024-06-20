import 'package:json_annotation/json_annotation.dart';

part 'daily_prayer_model.g.dart';

@JsonSerializable()
class DailyPrayerModel {
  String id;
  String? id_id;
  String doa;
  String ayat;
  String latin;
  String artinya;

  DailyPrayerModel({
    required this.id,
    this.id_id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  factory DailyPrayerModel.fromJson(Map<String, dynamic> json) {
    // Buat salinan modifiable dari Map
    final modifiableJson = Map<String, dynamic>.from(json);

    // Konversi dari int ke String jika perlu
    if (modifiableJson['id_id'] != null && modifiableJson['id_id'] is int) {
      modifiableJson['id_id'] = modifiableJson['id_id'].toString();
    }

    if (modifiableJson['id'] != null && modifiableJson['id'] is int) {
      modifiableJson['id'] = modifiableJson['id'].toString();
    }
    return _$DailyPrayerModelFromJson(modifiableJson);
  }

  /// Connect the generated [_$DailyPrayerModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DailyPrayerModelToJson(this);
}

class ExpandableDailyPrayerModel {
  DailyPrayerModel dailyPrayer;
  bool isExpanded;

  ExpandableDailyPrayerModel({
    required this.dailyPrayer,
    this.isExpanded = false,
  });
}
