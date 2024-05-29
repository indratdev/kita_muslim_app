import 'package:json_annotation/json_annotation.dart';

part 'article_muslim_model.g.dart';

@JsonSerializable()
class ArticleMuslimModel {
  bool success;
  String message;
  Data? data;

  ArticleMuslimModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ArticleMuslimModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleMuslimModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleMuslimModelToJson(this);
}

@JsonSerializable()
class Data {
  Pagination? pagination;
  List<Datum>? data;

  Data({
    this.pagination,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Datum {
  String? id;
  String? date;
  String? dateTime;
  String? thumbnail;
  String? author;
  String? authorLink;
  String? title;
  String? url;
  String? type;
  List<dynamic>? categories;
  String? content_html;

  Datum({
    this.id,
    this.date,
    this.dateTime,
    this.thumbnail,
    this.author,
    this.authorLink,
    this.title,
    this.url,
    this.type,
    this.categories,
    this.content_html,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Pagination {
  String? totalPage;

  Pagination({
    this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
