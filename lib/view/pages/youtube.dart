import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todos/model/country_list.dart';
import 'package:todos/provider/popular_provider.dart';
import 'package:todos/view/video_page.dart';

class YoutubePopular extends ConsumerStatefulWidget {

  @override
  ConsumerState<YoutubePopular> createState() => _YoutubePopularState();
}

class _YoutubePopularState extends ConsumerState<YoutubePopular> {
  String shortenCount(String count) {
    final intCount = int.tryParse(count);
    if (intCount != null) {
      if (intCount >= 1000000000) {
        final doubleCount = intCount / 1000000000;
        if (doubleCount >= 10) {
          return '${doubleCount.round()}B';
        } else {
          return doubleCount.toStringAsFixed(1) + 'B';
        }
      } else if (intCount >= 1000000) {
        final doubleCount = intCount / 1000000;
        if (doubleCount >= 10) {
          return '${doubleCount.round()}M';
        } else {
          return doubleCount.toStringAsFixed(1) + 'M';
        }
      } else if (intCount >= 1000) {
        final doubleCount = intCount / 1000;
        if (doubleCount >= 10) {
          return '${doubleCount.round()}K';
        } else {
          return doubleCount.toStringAsFixed(1) + 'K';
        }
      } else {
        return intCount.toString();
      }
    } else {
      return count;
    }
  }

  String? selectedCountry;


  @override
  Widget build(BuildContext context) {
    final ytPopularVideos = ref.watch(popularVideoProvider);
    return Scaffold(
      backgroundColor: const Color(0xff393646),
      body: ytPopularVideos.isError ? Center(child: Text(ytPopularVideos.errorMessage),) :
      ytPopularVideos.isLoad ? Center(child: CircularProgressIndicator(color: Colors.white,),)  :
      NotificationListener(
        onNotification: (ScrollEndNotification onNotification) {
          final before = onNotification.metrics.extentBefore;
          final max = onNotification.metrics.maxScrollExtent;
          // print('$before ---- $max');
          final nextPageToken = ytPopularVideos.popularVideos.nextPageToken;
          print(nextPageToken);
          if (before == max) {
            ref.read(popularVideoProvider.notifier).loadMore(pageToken: nextPageToken);
          }
          return true;
        },
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Popular videos from', style: TextStyle(color: Colors.white),),
            //       PopupMenuButton<CountryList>(
            //           itemBuilder: (context){
            //             return CountryList.countryList().map((e) =>
            //         PopupMenuItem<CountryList>(
            //           value: e,
            //           child: Text(e.countryName),
            //         )
            //         ).toList();
            //       },
            //       child: Container(
            //         alignment: Alignment.centerRight,
            //         width: 100.w,
            //         padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(4.0),
            //           border: Border.all(color: Colors.white)
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text('$selectedCountry',style: TextStyle(color: Colors.white),),
            //             Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.white, size: 20,)
            //           ],
            //         ),
            //       ),
            //         onSelected: (CountryList? countryList)async{
            //             if(countryList != null){
            //               setState(() {
            //                 selectedCountry = countryList.countryCode;
            //                 ref.read(popularVideoProvider.notifier).getPopular('$selectedCountry');
            //               });
            //             }
            //         },
            //       )
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                  itemCount: ytPopularVideos.popularVideos.items.length,
                  itemBuilder: (context, index){
                    final popular = ytPopularVideos.popularVideos.items[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=> VideoPage(video: popular), transition: Transition.rightToLeftWithFade);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                height: 180.h,
                                color: Colors.grey,
                                child: Image.network(popular.snippet.thumbnails.maxres.url, fit: BoxFit.fill,)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(popular.snippet.title,style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Flexible(child: Text(popular.snippet.channelTitle,style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),)),
                                  const Text(' | ', style: TextStyle(color: Colors.white)),
                                  Text('${shortenCount(popular.statistics.viewCount)} views',style: TextStyle(color: Colors.grey),),
                                  const Text(' | ', style: TextStyle(color: Colors.white)),
                                  Text('${shortenCount(popular.statistics.likeCount)} likes',style: TextStyle(color: Colors.grey),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            ytPopularVideos.isLoadMore == true ?
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Transform.scale(
                  scale: 0.8,
                  child: CircularProgressIndicator(color: Colors.white)),
            )
                : Container()
          ],
        ),
      )
    );
  }
}
