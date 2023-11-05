import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todos/provider/ship_provider.dart';

import '../../ship_detail.dart';

class ShipFreeze extends ConsumerWidget {
   ShipFreeze({super.key});
  final txtStyle = TextStyle(color: Colors.white);


  @override
  Widget build(BuildContext context, ref) {
    final ship = ref.watch(shipsProviderFreezed);
    return Scaffold(
      backgroundColor: const Color(0xff393646),
      body: ship.isRefreshing ? const Center(child: CupertinoActivityIndicator(color: Colors.blueAccent,)) : ship.when(
          data: (data){
            return RefreshIndicator(
              backgroundColor: const Color(0xff393646),
                color: Colors.white,
                onRefresh: () async{
                ref.invalidate(shipsProviderFreezed);
              },
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    final ships = data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=> ShipDetail(ships: ships),transition: Transition.rightToLeftWithFade);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.white)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ship_name',style: txtStyle),
                                  Text('ship_type',style: txtStyle),
                                  Text('weight_kg',style: txtStyle),
                                  Text('year_built',style: txtStyle),
                                  Text('home_port',style: txtStyle),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(':', style: txtStyle,),
                                  Text(':', style: txtStyle,),
                                  Text(':', style: txtStyle,),
                                  Text(':', style: txtStyle,),
                                  Text(':', style: txtStyle,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ships.ship_name,style: txtStyle,),
                                  Text(ships.ship_type, style: txtStyle),
                                  Text(ships.weight_kg == 0 ? 'n/a' : ships.weight_kg.toString(),style: txtStyle),
                                  Text(ships.year_built == 0 ? 'n/a' : ships.year_built.toString(),style: txtStyle),
                                  Text(ships.home_port, style: txtStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
          error: (error, stack){
            print(error);
            return Text(error.toString());
          } ,
          loading: ()=> Center(child: CupertinoActivityIndicator(color: Colors.white,))
      ),
    );
  }
}
