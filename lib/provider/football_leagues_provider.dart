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
        'APIkey': 'a97b14c7384ba05ea85cf2506e2e8eeb7f19b4e7d15e1f22a00efc96c5496c5e'
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
        'APIkey': 'a97b14c7384ba05ea85cf2506e2e8eeb7f19b4e7d15e1f22a00efc96c5496c5e'
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
