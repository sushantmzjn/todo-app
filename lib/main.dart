import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todos/model/meal%20model/meal.dart';
import 'package:todos/model/total%20calorie%20model/calorie.dart';
import 'package:todos/view/drawer/Drawer.dart';

import 'model/todos.dart';

//new task box
final box = Provider<List<ToDo>>((ref) => []);
//calorie box
final box1 = Provider<List<TotalCalorie>>((ref) => []);
//meal box
final box2 = Provider<List<Meal>>((ref) => []);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff393646),
  ));
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  Hive.registerAdapter(TotalCalorieAdapter());
  Hive.registerAdapter(MealAdapter());
  final taskBox =await Hive.openBox<ToDo>('task');
  final calorieBox =await Hive.openBox<TotalCalorie>('total_calorie');
  final mealBox =await Hive.openBox<Meal>('meal');
  runApp(ProviderScope(
    overrides: [
      box.overrideWithValue(taskBox.values.toList()),
      box1.overrideWithValue(calorieBox.values.toList()),
      box2.overrideWithValue(mealBox.values.toList()),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff393646)
            )
          ),
          home: HiddenDrawerWidget(),
        );
      },
    );
  }
}
