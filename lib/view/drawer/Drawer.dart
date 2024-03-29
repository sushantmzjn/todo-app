import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:todos/about.dart';

import 'package:todos/view/pages/calorie.dart';
import 'package:todos/view/pages/home_page.dart';
import 'package:todos/view/pages/news.dart';
import 'package:todos/view/pages/shipfreezed.dart';
import 'package:todos/view/pages/ships.dart';

import '../pages/football.dart';
import '../pages/youtube.dart';

class HiddenDrawerWidget extends StatefulWidget {
  @override
  State<HiddenDrawerWidget> createState() => _HiddenDrawerWidgetState();
}

class _HiddenDrawerWidgetState extends State<HiddenDrawerWidget> {
  List<ScreenHiddenDrawer> _pages = [];

  final txtStyle = TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 1);
  final selectedTxtStyle = TextStyle(
      color: const Color(0xff393646),
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: const Color(0xff393646),
              name: 'Task List',
              baseStyle: txtStyle,
              selectedStyle: selectedTxtStyle),
          HomePage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              colorLineSelected: const Color(0xff393646),
              name: 'Calorie',
              baseStyle: txtStyle,
              selectedStyle: selectedTxtStyle),
          Calorie()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: const Color(0xff393646),
            name: 'News', baseStyle: txtStyle, selectedStyle: selectedTxtStyle),
        News(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: const Color(0xff393646),
            name: 'Ships', baseStyle: txtStyle, selectedStyle: selectedTxtStyle),
        ShipFreeze(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: const Color(0xff393646),
            name: 'Football', baseStyle: txtStyle, selectedStyle: selectedTxtStyle),
        Football(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: const Color(0xff393646),
            name: 'Youtube Popular', baseStyle: txtStyle, selectedStyle: selectedTxtStyle),
        YoutubePopular(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: const Color(0xff393646),
            name: 'About Me', baseStyle: txtStyle, selectedStyle: selectedTxtStyle),
        About(),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: const Color(0xff393646).withOpacity(0.8),
      slidePercent: 50.0,
      screens: _pages,
      initPositionSelected: 0,
      isDraggable: true,
      elevationAppBar: 0,
      backgroundColorAppBar: const Color(0xff393646),
      styleAutoTittleName: TextStyle(color: Colors.white),
      leadingAppBar: Icon(Icons.menu_sharp,color: Colors.white,),
      isTitleCentered: true,
    );
  }
}
