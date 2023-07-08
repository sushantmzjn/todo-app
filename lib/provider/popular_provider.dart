

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/model/youtube%20popular%20videos%20model/video_state.dart';
import 'package:todos/model/youtube%20popular%20videos%20model/youtube_popular.dart';

import '../services/popular_services.dart';

YoutubePopular yt =YoutubePopular(
    nextPageToken: '',
    items: []
);


final popularVideoProvider = StateNotifierProvider<PopularVideos, VideoState>((ref) => PopularVideos(
  VideoState(isLoad: false, isError: false, errorMessage: '', popularVideos: yt, isLoadMore: false, pageToken: '')
));


class PopularVideos extends StateNotifier<VideoState>{

  PopularVideos(super.state){
    getPopular();
  }

  Future<void> getPopular()async{
    state = state.copyWith(isLoad: state.isLoadMore ? false : true, isError: false, errorMessage: '');

    final res = await PopularVideoServices.getPopularVideos(pageToken: state.pageToken);
    res.fold(
            (l) => state = state.copyWith(isLoad: false, isError: true, errorMessage: l, isLoadMore: false),
            (r) {
              final updatedItems = [...state.popularVideos.items, ...r.items];
              final updatedPopularVideos = YoutubePopular(nextPageToken: r.nextPageToken, items: updatedItems);
              state = state.copyWith(isLoad: false, isError: false, isLoadMore: false , popularVideos: updatedPopularVideos);
            }

    );
  }

  Future<void> loadMore({required String pageToken})async {
    state = state.copyWith(isLoadMore: true, pageToken: pageToken );
    getPopular();
  }
}