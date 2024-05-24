import 'package:json_annotation/json_annotation.dart';

part 'hadistRange_model.g.dart';

@JsonSerializable()
class HadistRangeModel {
  int code;
  String message;
  Data? data;
  bool error;

  HadistRangeModel({
    required this.code,
    required this.message,
    required this.error,
    required this.data,
  });

  factory HadistRangeModel.fromJson(Map<String, dynamic> json) =>
      _$HadistRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HadistRangeModelToJson(this);
}

@JsonSerializable()
class Data {
  String name, id;
  int available, requested;
  List<Hadiths> hadiths;

  Data({
    required this.name,
    required this.id,
    required this.available,
    required this.requested,
    required this.hadiths,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Hadiths {
  int number;
  String arab, id;

  Hadiths({
    required this.number,
    required this.arab,
    required this.id,
  });

  factory Hadiths.fromJson(Map<String, dynamic> json) =>
      _$HadithsFromJson(json);

  Map<String, dynamic> toJson() => _$HadithsToJson(this);
}
