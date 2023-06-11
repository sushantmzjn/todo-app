import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/provider/football_leagues_provider.dart';

class FootballLeaguesList extends ConsumerWidget {
  FootballLeaguesList({Key? key}) : super(key: key);

  final myText=TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context, ref) {
    final FootballLeagues = ref.watch(footballLeaguesProvider);
    return Scaffold(
        backgroundColor: const Color(0xff393646),
        appBar: AppBar(
          title: Text('Football Leagues'),
          centerTitle: true,
          elevation: 0,
        ),
        body: FootballLeagues.when(
            data: (data) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final leagueData = data[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.5),
                        border: Border.all(color: Colors.white)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 150.h,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(6.0), topLeft: Radius.circular(6.0)),
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) => Center(child: Text('Image Not found', style: myText)),
                                placeholder: (context, url) => Center(child: CupertinoActivityIndicator(color: Colors.white,)),
                                fit: BoxFit.fill,
                                imageUrl: leagueData.league_logo,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(leagueData.league_name,style: myText,),
                                SizedBox(height: 2.h,),
                                Text(leagueData.country_name,style: myText,),
                                SizedBox(height: 2.h,),
                                SizedBox(
                                  height: 30,
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) => Text('Image Not found', style: TextStyle(color: Colors.white),),
                                    placeholder: (context, url) => CupertinoActivityIndicator(color: Colors.white,),
                                    fit: BoxFit.fill,
                                    imageUrl: leagueData.country_logo,
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  });
            },
            error: (error, stack) => Text('$error'),
            loading: () => Center(child: CupertinoActivityIndicator(color: Colors.white, radius: 18,))));
  }
}
