// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_muslim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleMuslimModel _$ArticleMuslimModelFromJson(Map<String, dynamic> json) =>
    ArticleMuslimModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArticleMuslimModelToJson(ArticleMuslimModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pagination': instance.pagination,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String?,
      date: json['date'] as String?,
      dateTime: json['dateTime'] as String?,
      thumbnail: json['thumbnail'] as String?,
      author: json['author'] as String?,
      authorLink: json['authorLink'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      categories: json['categories'] as List<dynamic>?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'dateTime': instance.dateTime,
      'thumbnail': instance.thumbnail,
      'author': instance.author,
      'authorLink': instance.authorLink,
      'title': instance.title,
      'url': instance.url,
      'type': instance.type,
      'categories': instance.categories,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      totalPage: json['totalPage'] as String?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalPage': instance.totalPage,
    };
