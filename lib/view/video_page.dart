import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pod_player/pod_player.dart';

import '../model/youtube popular videos model/youtube_popular.dart';
class VideoPage extends StatelessWidget {
  final Items video;
  VideoPage({required this.video});


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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff393646),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.red,
              child: VideoPlay(video.id),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
              child: Text(video.snippet.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),),
            ),

            Flexible(child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(video.snippet.channelTitle,style: TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
              child: Row(
                children: [
                  Text('${shortenCount(video.statistics.viewCount)} views',style: TextStyle(color: Colors.grey),),
                  const Text(' | ', style: TextStyle(color: Colors.white)),
                  Text('${shortenCount(video.statistics.likeCount)} likes',style: TextStyle(color: Colors.grey),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class VideoPlay extends StatefulWidget {
  final String keys;
  VideoPlay(this.keys);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.keys}'),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
        ))..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
        child: widget.keys == ''
            ? const Center(child: Text('video not available'))
            : PodVideoPlayer(controller: controller));
  }
}

