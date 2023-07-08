import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todos/news_details.dart';

import '../../provider/news_provider.dart';

class News extends ConsumerStatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  ConsumerState<News> createState() => _NewsState();
}

class _NewsState extends ConsumerState<News> {

  TextEditingController searchController = TextEditingController();
  final _form = GlobalKey<FormState>();
  LocationPermission? permission;
  Position? position;


  //request location permission
  void _requestLocationPermission()async{
    permission = await Geolocator.requestPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }else if(permission == LocationPermission.deniedForever){
      await Geolocator.openAppSettings();
    }else if(permission == LocationPermission.always || permission==LocationPermission.whileInUse){
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('permission allowed');
      if(position!=null){
        print('${position!.latitude}, ${position!.latitude}');
        List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
        // print(placemarks[0]);
        searchController.text = placemarks[0].subAdministrativeArea!;
        ref.read(newProvider.notifier).getNews(q: searchController.text.trim());

      }else{

      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestLocationPermission();
  }


  @override
  Widget build(BuildContext context) {
    final newsData = ref.watch(newProvider);
    return Scaffold(
      backgroundColor: const Color(0xff393646),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Form(
              key: _form,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return 'required';
                        }
                        return null;
                      },
                      controller: searchController,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white,),
                          floatingLabelStyle: TextStyle(color: Colors.white),
                          labelText: 'Search',
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: (){
                    _form.currentState!.save();
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                    ref.read(newProvider.notifier).getNews(q: searchController.text.trim());
                    }
                  }, child: Text('Search', style: TextStyle(color: Colors.white),))
                ],
              ),
            ),
          ),
          newsData.isLoad ? Center(child: CupertinoActivityIndicator(color: Colors.white)) :
          newsData.isError ? Center(child: Text(newsData.errorMessage,style: TextStyle(color: Colors.white, fontSize: 15.sp),))
              : Expanded(
            child: RefreshIndicator(
              onRefresh: ()async {
                searchController.text.trim().isEmpty ? _requestLocationPermission()  :
                ref.refresh(newProvider.notifier).getNews(q: searchController.text.trim());
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: newsData.news.length,
                  itemBuilder: (context, index){
                   final news = newsData.news[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=> NewsDetail(news: news), transition: Transition.rightToLeftWithFade);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.white)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error)=> const Text('image not found', style: TextStyle(color: Colors.white),),
                                  placeholder: (context, url)=> Center(child: CupertinoActivityIndicator(color: Colors.white,)),
                                  imageUrl: news.urlToImage,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(news.title, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 12.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Source : ', style: TextStyle(color: Colors.white, fontSize: 12.sp),),
                                            Text(news.source.name, style: TextStyle(color: Colors.blue, fontSize: 12.sp),),
                                          ],
                                        ),
                                        Text(DateFormat('yMMMMd').format(DateTime.parse(news.publishedAt)),style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
                                      ],
                                    )
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    );

              }),
            ),
          )
        ],
      ),
    );
  }
}
