import 'package:json_annotation/json_annotation.dart';

part 'hadistsR_model.g.dart';

@JsonSerializable()
class HadistsRModel {
  HadistsRModel({
    this.code = 0,
    this.message = '',
    this.data,
    this.error = false,
  });

  int code;
  String message;
  Data? data;
  bool error;

  factory HadistsRModel.fromJson(Map<String, dynamic> json) =>
      _$HadistsRModelFromJson(json);

  Map<String, dynamic> toJson() => _$HadistsRModelToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.name,
    required this.id,
    this.available = 0,
    required this.contents,
  });

  String name;
  String id;
  int available;
  ContentsR contents;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ContentsR {
  ContentsR({
    this.number = 0,
    required this.arab,
    required this.id,
  });

  int number;
  String arab;
  String id;

  factory ContentsR.fromJson(Map<String, dynamic> json) =>
      _$ContentsRFromJson(json);

  Map<String, dynamic> toJson() => _$ContentsRToJson(this);
}
