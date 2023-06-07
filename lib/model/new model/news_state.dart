import 'package:todos/model/new%20model/news.dart';

class NewsState {
  final bool isLoad;
  final bool isError;
  final String errorMessage;
  final List<News> news;

  NewsState({
    required this.isLoad,
    required this.isError,
    required this.errorMessage,
    required this.news,
  });

  NewsState copyWith(
      {bool? isLoad,
      bool? isError,
      String? errorMessage,
      List<News>? news,
      }) {
    return NewsState(
      isLoad: isLoad ?? this.isLoad,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      news: news ?? this.news,
    );
  }
}
