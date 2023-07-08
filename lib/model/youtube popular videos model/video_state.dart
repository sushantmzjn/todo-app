import 'package:todos/model/youtube%20popular%20videos%20model/youtube_popular.dart';

class VideoState {
  final bool isLoad;
  final bool isError;
  final String errorMessage;
  final YoutubePopular popularVideos;
  final String pageToken;
  final bool isLoadMore;

  VideoState(
      {required this.isLoad,
      required this.isError,
      required this.errorMessage,
      required this.popularVideos,
      required this.pageToken,
      required this.isLoadMore});

  VideoState copyWith(
      {bool? isLoad,
      bool? isError,
      String? errorMessage,
      YoutubePopular? popularVideos,
      String? pageToken,
      bool? isLoadMore}) {
    return VideoState(
      isLoad: isLoad ?? this.isLoad,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      popularVideos: popularVideos ?? this.popularVideos,
      pageToken: pageToken ?? this.pageToken,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }
}
