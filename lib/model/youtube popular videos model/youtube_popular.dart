class YoutubePopular{
  String nextPageToken;
  List<Items> items;

  YoutubePopular({required this.nextPageToken, required this.items});

  factory YoutubePopular.fromJson(Map<String, dynamic>json){
    return YoutubePopular(
        nextPageToken: json['nextPageToken'] ?? '',
        items: List<Items>.from(json['items'].map((e)=> Items.fromJson(e))) ?? []
    );
  }
}


class Items {
  String id;
  Snippet snippet;
  Statistics statistics;

  Items({required this.id, required this.snippet, required this.statistics});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        id: json['id']?? '',
        snippet: Snippet.fromJson(json['snippet'] ?? {}),
        statistics: Statistics.fromJson(json['statistics'] ?? {})
    );
  }
}

class Snippet {
  String publishedAt;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;

  Snippet(
      {required this.publishedAt,
      required this.title,
      required this.description,
      required this.thumbnails,
      required this.channelTitle,
    });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
        publishedAt: json['publishedAt'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        thumbnails: Thumbnails.fromJson(json['thumbnails'] ?? {}),
        channelTitle: json['channelTitle'] ?? '',
        );
  }
}

class Thumbnails {
  Maxres maxres;

  Thumbnails({required this.maxres});

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return Thumbnails(maxres: Maxres.fromJson(json['medium'] ?? {}));
  }
}

class Maxres {
  String url;

  Maxres({required this.url});

  factory Maxres.fromJson(Map<String, dynamic> json) {
    return Maxres(url: json['url'] ?? '');
  }
}

class Statistics {
  String viewCount;
  String likeCount;
  String commentCount;

  Statistics({
    required this.viewCount,
    required this.likeCount,
    required this.commentCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
        viewCount: json['viewCount'] ?? '0',
        likeCount: json['likeCount'] ?? '0',
        commentCount: json['commentCount'] ?? '0');
  }
}
