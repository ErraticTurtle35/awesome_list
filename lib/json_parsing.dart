import 'dart:convert' as converter;
import 'package:awersome_list/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  int get id;

  @nullable
  bool get deleted;

  String get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Article._();
  factory Article([updates(ArticleBuilder b)]) = _$Article;
}

List<int> parseTopStories(String json) {
  return [];
//  final parsedTopStories = converter.jsonDecode(json);
//  final topStoriesIds = List<int>.from(parsedTopStories);
//  return topStoriesIds;
}

Article parseArticle(String json) {
  final parsedArticle = converter.jsonDecode(json);
  Article article =
      standardSerializers.deserializeWith(Article.serializer, parsedArticle);
  return article;
}
