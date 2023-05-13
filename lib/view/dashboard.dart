import 'package:flutter/material.dart';
import 'package:todos/view/drawer/drawer_widget.dart';
import 'package:todos/view/home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _HomePageState();
}

class _HomePageState extends State<Dashboard> {
  final double xOffset = 280;
  final double maxSlide = 225.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393646),
      body: SafeArea(
        child: Stack(
          children: [
            DrawerWidget(),
            HomePage()
          ],
        ),
      ),
    );
  }
}
