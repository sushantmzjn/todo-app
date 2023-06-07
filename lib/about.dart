import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xff393646),
      body: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://scontent.fktm7-1.fna.fbcdn.net/v/t1.18169-9/26112078_1985706811704543_6013809511908769784_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ngXaHKMMIzAAX-lE9PX&_nc_oc=AQlHtrWqoLesM0GKNixoPjrUwgCc2P0XoACy7cDy5uMnIKm6aOLfSsau2_K2cMcelDvcKcqP0U6PokrTQsthzPD_&_nc_ht=scontent.fktm7-1.fna&oh=00_AfBJNxGyPV_-sI3330BhMcSWbIgQ-YkgXNVUJGszaKPpAg&oe=64A7964A'),
          ),
          SizedBox(height: 12.h,),
          Text('Sushant Maharjan', style: TextStyle(color: Colors.white, fontSize: 16.sp),),
          SizedBox(height: 2.h,),
          GestureDetector(
              onTap: ()async{
                const email ='sushantmaharjan08@gmail.com';
                const url = 'mailto:$email';
                urlLaunch(url);
              },
              child: Text('sushantmaharjan08gmail.com', style: TextStyle(color: Colors.blue, fontSize: 12.sp, decoration: TextDecoration.underline),)),
          SizedBox(height: 1.h,),
          Text('Bungmati, Lalitpur 22', style: TextStyle(color: Colors.white, fontSize: 12.sp),),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://www.facebook.com/sushantmaharjan4/');
                  },
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white)
              ),
              SizedBox(width: 10.h,),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://www.instagram.com/sushant__mz/');
                  },
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white,)
              ),
              SizedBox(width: 10.h,),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://www.linkedin.com/in/sushant-maharjan-58043b246/');
                  },
                  icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white)
              ),
              SizedBox(width: 10.h,),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://github.com/sushantmzjn');
                  },
                  icon: FaIcon(FontAwesomeIcons.github, color: Colors.white)
              )
            ],
          )
        ],
      ),
    );
  }
}
