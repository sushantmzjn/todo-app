import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:todos/provider/ship_provider.dart';
import 'package:todos/ship_detail.dart';

class Ships extends ConsumerWidget {
   Ships({Key? key}) : super(key: key);

  final txtStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context, ref) {
    final shipData = ref.watch(shipProvider);
    return Scaffold(
      backgroundColor: const Color(0xff393646),
      body:shipData.isRefreshing ? const Center(child: CupertinoActivityIndicator(color: Colors.blueAccent,)) : shipData.when(
          data: (data){
            return RefreshIndicator(
              onRefresh: () async{
                ref.invalidate(shipProvider);
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
