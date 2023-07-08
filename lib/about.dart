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
            backgroundImage: NetworkImage('https://scontent.fktm7-1.fna.fbcdn.net/v/t1.18169-9/26112078_1985706811704543_6013809511908769784_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=0A0CxcxKKFAAX98ZrE0&_nc_oc=AQkapZYjknvfez9STV4XdeVdyo2-71VSTdo7Q29AI-76yLWKBYpIJaTEGB6c8063ez6nzNtYbpW7z_vFv9o11C99&_nc_ht=scontent.fktm7-1.fna&oh=00_AfCp5B6V1MvNXqW_7af6fDkBVvZbPNx9VSIQ6NmAowpQgA&oe=64D0AD0A'),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
