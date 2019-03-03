import 'package:flutter/material.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
          return new Future.delayed(const Duration(seconds: 1));
        },
        child: new ListView(
          children: _articles.map(_buildArticleItem).toList(),
        ),
      ),
    );
  }

  Widget _buildArticleItem(Article article) {
    return Padding(
      key: Key(article.text),
      padding: const EdgeInsets.all(8.0),
      child: new ExpansionTile(
        title: new Text(article.text, style: new TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text("${article.commentsCount} comments"),
              new IconButton(
                icon: new Icon(Icons.launch),
                color: Colors.blueGrey,
                onPressed: () async {
                  final fakeUrl = "https://flutter.dev";
                  if (await canLaunch(fakeUrl)) {
                    launch(fakeUrl);
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