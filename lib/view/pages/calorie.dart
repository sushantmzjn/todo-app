import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../model/meal model/meal.dart';
import '../../model/total calorie model/calorie.dart';
import '../../provider/autoValidate_provider.dart';
import '../../provider/calorie_provider.dart';
import '../common widget/calorie_alert_dialog.dart';
import '../common widget/snackbar.dart';


class Calorie extends ConsumerWidget {

  TextEditingController mealController =  TextEditingController();
  TextEditingController calorieController =  TextEditingController();
  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, ref) {

    final mealData = ref.watch(calorieAddProvider);
    final mode = ref.watch(autoValidateMode);

    final totalCaloriesByDate = ref.watch(calorieAddProvider.notifier).calculateTotalCaloriesByDate();


    return  Scaffold(
      backgroundColor: const Color(0xff393646),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300.h,
                  child: mealData.isEmpty ? Center(child: Text('Your Calorie List  is Empty')) : ListView.builder(
                      itemCount: mealData.length,
                      itemBuilder: (context, index){
                        final now = DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
                        return  now != DateFormat('yyyy-MM-dd').format(DateTime.parse(mealData[index].dateTime))
                            ? Container() : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Date : ${mealData[index].dateTime}', style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                                  Text('Total Calorie : ${mealData[index].totalCalorie.toString()}', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Container(
                                height: 250.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Colors.white)
                                ),
                                child: ListView.builder(
                                    itemCount: mealData[index].meal.length,
                                    itemBuilder: (context,position){
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(mealData[index].meal[position].name, style: TextStyle(color: Colors.white),),
                                            subtitle: Text(mealData[index].meal[position].dateTime,style: TextStyle(color: Colors.white)),
                                            trailing: Text(mealData[index].meal[position].calorie.toString(), style: TextStyle(color: Colors.white)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
                                          ),
                                          Divider(
                                            color: Colors.white,
                                            height: 0,)
                                        ],
                                      );


                                    }),
                              ),
                            )
                          ],
                        );
                      }),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Daily Calorie Intake', style: TextStyle(fontSize: 15.sp, letterSpacing: 0.5,  color: Colors.white))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 220.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Date', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(width: 35.w,),
                            Text('Total Calorie', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color:  Colors.white)),
                          ],
                        ),
                        Divider(color: Colors.white,),
                        Flexible(
                          child: ListView.builder(
                              itemCount: mealData.length,
                              itemBuilder: (context, i){
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(mealData[i].dateTime,style: TextStyle(color: Colors.white)),
                                        SizedBox(width: 35.w,),
                                        Text(mealData[i].totalCalorie.toString(), style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Divider(color: Colors.white,)
                                  ],
                                );

                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),



      //---------------FAB-----------------------------------------------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        mini: true,
        backgroundColor: const Color(0xff393646),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.white, width: 0.5,)
        ),
        onPressed: ()async{
          await showModal(
            configuration: const FadeScaleTransitionConfiguration(
                transitionDuration: Duration(milliseconds: 400)
            ),
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Form(
                    key: _form,
                    autovalidateMode: mode,
                    child: CalorieAlertDialog(
                      mealController: mealController,
                      calorieController: calorieController,
                      mealKeyboardType: TextInputType.text,
                      calorieKeyboardType: TextInputType.number,
                      mealLabelText: 'Meal',
                      calorieLabelText: 'Calorie',
                      mealValidator: (val){
                        if(val!.isEmpty){
                          return 'required';
                        }
                      },
                      calorieValidator: (val){
                        if(val!.isEmpty){
                          return 'required';
                        }
                      },
                      onPressed: (){
                        _form.currentState!.save();
                        FocusScope.of(context).unfocus();
                        if(_form.currentState!.validate()){

                          final meal = [
                            Meal(
                                name: mealController.text,
                                calorie: int.parse(calorieController.text),
                                dateTime: DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()))
                            )
                          ];

                          final response = ref.read(calorieAddProvider.notifier).add(TotalCalorie(
                              totalCalorie: 0 + int.parse(calorieController.text),
                              dateTime: DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString())),
                              meal: meal
                          ));

                          if( response == 'Success' ){
                            SnackShow.showSuccess(context, response);
                          }else if(response == 'meal added'){
                            SnackShow.showSuccess(context, response);
                          }
                          Navigator.of(context).pop();
                          mealController.clear();
                          calorieController.clear();
                        }else{
                          ref.read(autoValidateMode.notifier).autoValidate();
                        }
                      },
                    ),
                  );
                },
              );
            },

          );
        },
        child: Icon(Icons.add),

      ),
    );
  }
}



