import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api_exception.dart';
import '../model/youtube popular videos model/youtube_popular.dart';

class PopularVideoServices{
  static Dio dio = Dio();

  //get popular videos
static Future<Either<String, YoutubePopular>> getPopularVideos({required String pageToken})async{

  try{
    final res =await dio.get('https://youtube.googleapis.com/youtube/v3/videos', queryParameters: {
      'chart' : 'mostPopular',
      'key' : 'AIzaSyDuCH2dBYMVjixYBQQE71lFqrjqhKIlBSg',
      'part' : ['snippet', 'contentDetails', 'statistics'],
      'regionCode': 'US',
      'pageToken' : pageToken,
    });
    final data = YoutubePopular.fromJson(res.data);
    // final data = (res.data['items'] as List).map((e) => YoutubePopular.fromJson(e)).toList();
    // print(YoutubePopular.fromJson(res.data));
    return Right(data);

  }on DioException catch (err) {
    return Left(DioExceptioned.getDioError(err));
  }

}
}