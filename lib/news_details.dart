import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todos/model/new%20model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
 final News news;
 NewsDetail({required this.news});

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
    return Scaffold(
     appBar: AppBar(
      title: Text('News'),
      centerTitle: true,
      elevation: 0,
     ),
     body: ListView(
       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
       children: [
       Text(news.title, style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600, letterSpacing: 0.5),),
       SizedBox(height: 12.h,),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Flexible(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('Author : ', style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w600),),
                 Flexible(child: Text(news.author.isEmpty ? 'N/A' : news.author, style: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.w600, color: Colors.blue),)),
               ],
             ),
             Text(DateFormat('yMMMMd').format(DateTime.parse(news.publishedAt)),style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
            ],
           ),
         ),
         Row(
           children: [
             Text('Source : '),
             Text(news.source.name, style: TextStyle(color: Colors.blue),),
           ],
         )
       ],),
        SizedBox(height: 12.h,),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: CachedNetworkImage(
            errorWidget: (context, url, error)=> const Text('image not found',),
            placeholder: (context, url)=> Center(child: CupertinoActivityIndicator(color: Colors.white,)),
            imageUrl: news.urlToImage,),
        ),
        SizedBox(height: 6.h,),
        Text(news.description),
        SizedBox(height: 12.h,),
        ElevatedButton(
            onPressed: (){
              urlLaunch(news.url.trim());
              },
            child: Text('Read More'))
      ],
     ),
    );
  }
}
