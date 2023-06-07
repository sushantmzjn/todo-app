import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/model/ships%20model/ship.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipDetail extends StatelessWidget {
  final Ships ships;
  ShipDetail({super.key, required this.ships});

  final txtStyle = TextStyle(color: Colors.white);

  Future<void> urlLaunch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Error launching URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ships.roles.map((e) => e).toList().join(', ');

    return Scaffold(
      backgroundColor: const Color(0xff393646),
      appBar: AppBar(
        title: Text('Ship Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error)=> Text('image not found', style: txtStyle,),
              placeholder: (context, url)=> Center(child: CupertinoActivityIndicator(color: Colors.white,)),
              imageUrl: ships.image,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ship_name',style: txtStyle),SizedBox(height: 6.h,),
                        Text('ship_type',style: txtStyle),SizedBox(height: 6.h,),
                        Text('weight_kg',style: txtStyle),SizedBox(height: 6.h,),
                        Text('year_built',style: txtStyle),SizedBox(height: 6.h,),
                        Text('home_port',style: txtStyle),SizedBox(height: 6.h,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                        Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                        Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                        Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                        Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ships.ship_name,style: txtStyle,),SizedBox(height: 6.h,),
                        Text(ships.ship_type, style: txtStyle),SizedBox(height: 6.h,),
                        Text(ships.weight_kg == 0 ? 'n/a' : ships.weight_kg.toString(),style: txtStyle),SizedBox(height: 6.h,),
                        Text(ships.year_built == 0 ? 'n/a' : ships.year_built.toString(),style: txtStyle),SizedBox(height: 6.h,),
                        Text(ships.home_port, style: txtStyle),SizedBox(height: 6.h,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Text('Roles : ', style: txtStyle,),
                        Text(role.toString(), style: txtStyle),
                        // Text(ships.url)
                      ],
                    ),
                  ),
                  ships.url.trim().isEmpty ? Container() : ElevatedButton(onPressed: (){
                    urlLaunch(ships.url.trim());
                  }, child: Text('Read More', ))
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                itemCount: ships.missions.length,
                itemBuilder: (context,index){
                  final missions = ships.missions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mission Name',style: txtStyle,),SizedBox(height: 6.h,),
                              Text('Flight', style: txtStyle,),SizedBox(height: 6.h,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                              Text(' : ', style: txtStyle,),SizedBox(height: 6.h,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(missions.name, style: txtStyle),SizedBox(height: 6.h,),
                              Text(missions.flight.toString(), style: txtStyle),SizedBox(height: 6.h,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
            }),
          ],
        ),
      ),
    );
  }
}
