import 'package:awersome_list/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';

class HackerNewsBloc {
  final _articleSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];

  List<int> _storyIds = [
    19273955,
    19275755,
    19274406,
    19282346,
    19291558,
    19293916,
    19277809,
    19271487,
    19292382
  ];

  HackerNewsBloc() {
    _updateArticlesByStoryIds().then((_) {
      _articleSubject.add(UnmodifiableListView(_articles));
    });
  }

  Stream<UnmodifiableListView<Article>> get articles => _articleSubject.stream;

  Future<Article> _getArticleByStoryId(int storyId) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$storyId.json';
    final storyResponse = await http.get(storyUrl);
    if (storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }

  Future<Null> _updateArticlesByStoryIds() async {
    final futureArticles =
        _storyIds.map((storyId) => _getArticleByStoryId(storyId));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}
