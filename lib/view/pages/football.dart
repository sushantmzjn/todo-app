import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todos/football_leagues_list.dart';
import 'package:todos/provider/football_leagues_provider.dart';

import '../../match_detail.dart';

class Football extends ConsumerStatefulWidget {

  @override
  ConsumerState<Football> createState() => _FootballState();
}

class _FootballState extends ConsumerState<Football> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this)..repeat(reverse: true);
  late final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liveData = ref.watch(footballLiveScoreProvider);
    return Scaffold(
      backgroundColor: const Color(0xff393646),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.to(()=> FootballLeaguesList(), transition: Transition.rightToLeftWithFade);
            },
            child: Text('Football Leagues'),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Live Match',style: TextStyle(color: Colors.white)),
                    SizedBox(width: 6.w,),
                    FadeTransition(
                        opacity: animation,
                        child: Icon(CupertinoIcons.circle_fill, size: 10, color: Colors.lightGreenAccent,)
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async{
                    ref.invalidate(footballLiveScoreProvider);
                  },
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          ),

          Expanded(
              child: liveData.when(
                  data: (data){
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          final score= data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(()=> MatchDetail(score: score),transition: Transition.rightToLeftWithFade);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    //home
                                    Flexible(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height : 60.h,
                                              child: score.home_team_logo.trim().isEmpty ? Center(child: Text('image not available')): Image.network(score.home_team_logo)
                                          ),
                                          SizedBox(height: 2.h,),
                                          Text(score.event_home_team, textAlign: TextAlign.center),
                                          Text(score.event_home_formation, textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                    //score
                                    Flexible(
                                      child: Column(
                                        children: [
                                         Text(score.event_final_result, style: TextStyle(fontSize: 16.sp),),
                                          SizedBox(height: 10.h,),
                                          Text('Time : ${score.event_status}', style: TextStyle(fontSize: 10.sp),)
                                        ],
                                      ),
                                    ),
                                    //away
                                    Flexible(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height : 60.h,
                                              child: score.away_team_logo.trim().isEmpty ? Center(child: Text('image not available'))
                                                  : Image.network(score.away_team_logo)
                                          ),
                                          SizedBox(height: 2.h,),
                                          Text(score.event_away_team, textAlign: TextAlign.center,),
                                          Text(score.event_away_formation, textAlign: TextAlign.center),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                    });
                  },
                  error: (error, stack)=> Text('$error'),
                  loading: ()=> Center(child: CircularProgressIndicator(color: Colors.white,)))
          )
        ],
      ),
    );
  }
}
