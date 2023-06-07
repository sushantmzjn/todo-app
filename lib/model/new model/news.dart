class News {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String publishedAt;
  String content;
  String urlToImage;

  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.content,
    required this.urlToImage,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: Source.fromJson(json["source"]),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}

class Source {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };
}
