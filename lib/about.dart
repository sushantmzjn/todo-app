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
            backgroundImage: NetworkImage('https://instagram.fktm8-1.fna.fbcdn.net/v/t51.2885-19/315764971_657094225884180_413666657439481713_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fktm8-1.fna.fbcdn.net&_nc_cat=100&_nc_ohc=bGJxlbTwY38AX8QcT6L&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfCm30xCQWIplX_KxlsKYPwn1HPQYnKHjlqB_G2iv7zn5Q&oe=6517E79C&_nc_sid=8b3546'),
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
          SizedBox(height: 5.h,),
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
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://www.instagram.com/sushant__mz/');
                  },
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white,)
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: (){
                    urlLaunch('https://www.linkedin.com/in/sushant-maharjan-58043b246/');
                  },
                  icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white)
              ),
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
