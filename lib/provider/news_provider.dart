import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/model/new%20model/news_state.dart';
import 'package:todos/services/news_services.dart';

final newProvider = StateNotifierProvider<NewsProvider, NewsState>((ref) =>
    NewsProvider(NewsState(isError: false, isLoad: false, errorMessage: '', news: [])));

class NewsProvider extends StateNotifier<NewsState> {
  NewsProvider(super.state);

  Future<void> getNews({required String q}) async {
    state = state.copyWith(isLoad: true, isError: false, errorMessage: '');
    final res = await NewsServices.getNews(q: q);
    res.fold(
        (l) => state = state.copyWith(isLoad: false, isError: true, errorMessage: l),
        (r) => state = state.copyWith(isLoad: false, isError: false, news: r));
  }
}
