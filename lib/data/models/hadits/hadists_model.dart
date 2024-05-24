import 'package:json_annotation/json_annotation.dart';

part 'hadists_model.g.dart';

@JsonSerializable()
class HadistsModel {
  int code;
  String message;
  List<DataBooksHadists> data;
  bool error;

  HadistsModel({
    required this.code,
    required this.message,
    required this.data,
    this.error = false,
  });

  factory HadistsModel.fromJson(Map<String, dynamic> json) =>
      _$HadistsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HadistsModelToJson(this);
}

@JsonSerializable()
class DataBooksHadists {
  String name, id;
  int available;

  DataBooksHadists({
    required this.name,
    required this.id,
    required this.available,
  });

  factory DataBooksHadists.fromJson(Map<String, dynamic> json) =>
      _$DataBooksHadistsFromJson(json);

  Map<String, dynamic> toJson() => _$DataBooksHadistsToJson(this);
}
