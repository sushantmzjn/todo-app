
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/model/ships%20model/ship.dart';

import '../api_exception.dart';
import '../model/ships model/ship_freezed.dart';

final shipProvider = FutureProvider((ref) => ShipProvider.getShips());
final shipsProviderFreezed = FutureProvider((ref) => ShipProvider.getShipsFreezed());

class ShipProvider{
  static Dio dio = Dio();

  //get ship details
static Future<List<Ships>> getShips()async{
  try{
    final response = await dio.get('https://api.spacexdata.com/v3/ships');
    final data = (response.data as List).map((e) => Ships.fromJson(e)).toList();
    return data;
    
  }on DioException catch(err){
    print(err);
    throw DioExceptioned.getDioError(err);
  }

  }

  //freezed
  static Future<List<ShipsFreezed>> getShipsFreezed()async{
    try{
      final response = await dio.get('https://api.spacexdata.com/v3/ships');
      final data = (response.data as List).map((e) => ShipsFreezed.fromJson(e)).toList();
      return data;

    }on DioException catch(err){
      print(err);
      throw DioExceptioned.getDioError(err);
    }

  }
}