
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/model/ships%20model/ship.dart';

import '../api_exception.dart';

final shipProvider = FutureProvider((ref) => ShipProvider.getShips());

class ShipProvider{
  static Dio dio = Dio();

  //get ship details
static Future<List<Ships>> getShips()async{
  try{
    final response = await dio.get('https://api.spacexdata.com/v3/ships');
    final data = (response.data as List).map((e) => Ships.fromJson(e)).toList();
    return data;
    
  }on DioError catch(err){
    print(err);
    throw DioException.getDioError(err);
  }

  }
}