class Article {
  final String text;
  final String domain;
  final String by;
  final String age;
  final int score;
  final int commentsCount;

  const Article(
      {this.text,
      this.domain,
      this.by,
      this.age,
      this.score,
      this.commentsCount});
}

final articles = [
  new Article(
      text: "Some article 1",
      domain: "someart.one",
      by: "art1",
      age: "1h",
      score: 1,
      commentsCount: 100),
  new Article(
      text: "Some article 2",
      domain: "someart.two",
      by: "art2",
      age: "2h",
      score: 2,
      commentsCount: 200),
  new Article(
      text: "Some article 3",
      domain: "someart.three",
      by: "art3",
      age: "3h",
      score: 3,
      commentsCount: 300),
  new Article(
      text: "Some article 4",
      domain: "someart.four",
      by: "art4",
      age: "4h",
      score: 4,
      commentsCount: 400)
];
