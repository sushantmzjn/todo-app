import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/model/football%20model/football_live_score.dart';
import 'package:todos/provider/football_leagues_provider.dart';

class MatchDetail extends ConsumerWidget {
  final FootballLive score;
  MatchDetail({super.key, required this.score});

  @override
  Widget build(BuildContext context, ref) {

    return Scaffold(
      backgroundColor: const Color(0xff393646),
      appBar: AppBar(
        title: Text('Match Detail'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Event Date: ${score.event_date}', style: TextStyle(color: Colors.white),),
                    Text('Event Time: ${score.event_time}', style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('League Name: ${score.league_name}', style: TextStyle(color: Colors.white),),
                    Text('Event Stadium: ${score.event_stadium}', style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //home
                      Flexible(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 60.h,
                                child: score.home_team_logo.trim().isEmpty
                                    ? Center(child: Text('image not available'))
                                    : Hero(
                                    tag: 'image-${score.home_team_logo}',
                                    child: Image.network(score.home_team_logo))),
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
                            Text(
                              score.event_final_result,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Time : ${score.event_status}',
                              style: TextStyle(fontSize: 10.sp),
                            )
                          ],
                        ),
                      ),
                      //away
                      Flexible(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 60.h,
                                child: score.away_team_logo.trim().isEmpty
                                    ? Center(child: Text('image not available'))
                                    : Hero(
                                    tag: 'image-${score.away_team_logo}',
                                    child: Image.network(score.away_team_logo))),
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
             score.cards.isEmpty ? Container() : Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0)
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: score.cards.length,
                      itemBuilder: (context, index){
                        final foul = score.cards[index];
                        return Column(
                          children: [
                            Row(children: [
                              Text(foul.home_fault.isEmpty && foul.away_fault.isEmpty ? 'n/a' : '${foul.home_fault}${foul.away_fault}'),
                              foul.card == 'yellow card' ? Icon(Icons.rectangle, color: Colors.yellow, size: 18, ) :
                              foul.card == 'red card' ? Icon(Icons.rectangle, color: Colors.red,size: 18)
                                  : Container(),
                              Text(', ${foul.time}\''),
                            ],)
                          ],
                        );
                  }),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0)
                  ),
                  child: score.statistics.isEmpty ? Text('data is not added yet. please check back later or refresh') : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: score.statistics.length,
                      itemBuilder: (context, index){
                        final stat = score.statistics[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(stat.home),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(stat.type)
                              ],
                            ),
                            Column(
                              children: [
                                Text(stat.away)
                              ],
                            )
                          ],
                        );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0)
                  ),
                  child: score.goalscorers.isEmpty ? Text('data is not added yet. please check back later or refresh') :
                  ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: score.goalscorers.length,
                      itemBuilder: (context, index){
                        final goalScore = score.goalscorers[index];
                        return Row(
                          children: [
                            Text(goalScore.home_scorer),
                            Text(goalScore.away_scorer),
                            Text('${goalScore.home_scorer.isEmpty && goalScore.away_scorer.isEmpty ? 'n/a, ' : ','} ${goalScore.time} min'),
                          ],
                        );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
