
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todos/model/new%20model/news.dart';

import '../api_exception.dart';

class NewsServices{
  static Dio dio = Dio();

  //get news
static Future<Either<String, List<News>>> getNews({
   required String q
})async{
  try{
    final response = await dio.get('https://newsapi.org/v2/everything', queryParameters:{
      'q' : q,
      'apiKey': '460555605ada4774a3e5a9be34bf9f08'
    });
    if((response.data['articles'] as List).isEmpty){
      return left('result not found try another keyword');
    }else{
    final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
    return Right(data);
    }
  }on DioError catch(err){
    print(err);
    return Left(DioException.getDioError(err));
  }
}
}