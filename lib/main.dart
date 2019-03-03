import 'package:flutter/material.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _articlesIds = [
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

  Future<Article> _getArticleByStoryId(int storyId) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$storyId.json';
    final storyResponse = await http.get(storyUrl);
    if (storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _articlesIds
            .map((articleId) => FutureBuilder<Article>(
                  future: _getArticleByStoryId(articleId),
                  builder: (BuildContext context,
                      AsyncSnapshot<Article> articleSnapshot) {
                    if (articleSnapshot.connectionState ==
                        ConnectionState.done) {
                      return _buildArticleItem(articleSnapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildArticleItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(article.title , style: TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(article.type),
              IconButton(
                icon: Icon(Icons.launch),
                color: Colors.blueGrey,
                onPressed: () async {
                  if (await canLaunch(article.url)) {
                    launch(article.url);
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
