import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todos/model/football%20model/football_league.dart';
import '../api_exception.dart';
import '../model/football model/football_live_score.dart';

final footballLeaguesProvider = FutureProvider((ref) => FootballLeague.getFootballLeague());

class FootballLeague {
  static Dio dio = Dio();

  //get football leagues
  static Future<List<FootballLeagues>> getFootballLeague() async {
    try {
      final response = await dio
          .get('https://apiv2.allsportsapi.com/football', queryParameters: {
        'met': 'Leagues',
        'APIkey': 'c10180a310d05332a68addc4a02c7e3faf19f2388b8944493b351e6185aad089'
      });
      final data = (response.data['result'] as List).map((e) => FootballLeagues.fromJson(e)).toList();
      return data;
    } on DioError catch (err) {
      print(err);
      throw DioException.getDioError(err);
    }
  }
}


//football live score
final footballLiveScoreProvider = FutureProvider((ref) => FootballLiveScore.getLiveScore());

class FootballLiveScore {
  static Dio dio = Dio();

  static Future<List<FootballLive>> getLiveScore() async {
    try {
      final res = await dio.get('https://apiv2.allsportsapi.com/football', queryParameters: {
        'met': 'Livescore',
        'APIkey': 'c10180a310d05332a68addc4a02c7e3faf19f2388b8944493b351e6185aad089'
      });
      if(res.data['result'] == null){
        return Future.error('No Matches');
      }else{
      final data = (res.data['result']as List).map((e) => FootballLive.fromJson(e)).toList();
      return data;
      }

    } on DioError catch (err) {
      print(err);
      throw DioException.getDioError(err);
    }
  }
}
