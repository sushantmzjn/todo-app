import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:todos/model/todos.dart';
import 'package:todos/view/common%20widget/snackbar.dart';
import 'package:todos/view/task_dialog_box.dart';

import '../../provider/todos_provider.dart';

class HomePage extends ConsumerStatefulWidget {

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController updateTaskController = TextEditingController();
  bool isFab = true;

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(addTaskProvider);
    final taskDelete = ref.watch(addTaskProvider);
    final completedTask = ref.watch(addTaskProvider.notifier).countCompletedTasks(todos);
    return Scaffold(
      backgroundColor: const Color(0xff393646),

        body: NotificationListener<UserScrollNotification>(
              onNotification: (notification){
                if(notification.direction == ScrollDirection.forward){
                  if(!isFab) setState(() { isFab = true; });
                }else if(notification.direction == ScrollDirection.reverse){
                  if(isFab) setState(() { isFab = false; });
                }
                return true;
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    width: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.white)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Total Task', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                            SizedBox(height: 4.h,),
                            Text(todos.length.toString(), style: TextStyle(color: Colors.white, fontSize: 14.sp))
                          ],
                        ),
                        Container(
                          width: 0.5,
                          height: 45.h,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Completed Task',style: TextStyle(color: Colors.white, fontSize: 13.sp),),
                            SizedBox(height: 4.h,),
                            Text(completedTask.toString(), style: TextStyle(color: Colors.white, fontSize: 14.sp))
                          ],
                        ),
                      ],
                    ),
                  ),
                  todos.isEmpty ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                      SvgPicture.asset('assets/images/no_data.svg',
                        width: MediaQuery.of(context).size.width,
                        height: 180.h,
                        ),
                      Text('Todo list is empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      )
                    ],
                  ) : Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: todos.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.only(left: 0,top: 0, bottom: 0, right: 14.0),
                                leading: Checkbox(
                                  value: todos[index].isCompleted,
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.white)),
                                  onChanged: (bool? value) {
                                    setState(() {
                                    // todos[index].isCompleted = !todos[index].isCompleted;
                                      final res = ref.read(addTaskProvider.notifier).checkUpdate(todos[index]);
                                      if(res == true){
                                        SnackShow.showSuccess(context, 'Marked as done');
                                      }else{
                                        SnackShow.showFailure(context, 'Marked as incomplete');
                                      }
                                    });
                                  },
                                ),
                                title: Text(todos[index].title, style: TextStyle(
                                  color: todos[index].isCompleted == true ? Colors.grey : Colors.white ,
                                    decoration: todos[index].isCompleted == true ? TextDecoration.lineThrough :  TextDecoration.none),),
                                subtitle: Text(todos[index].dateTime, style: TextStyle(
                                  color: todos[index].isCompleted == true ? Colors.grey : Colors.white,
                                    decoration: todos[index].isCompleted == true ? TextDecoration.lineThrough :  TextDecoration.none
                                ),),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const VerticalDivider(
                                      color: Colors.white,
                                      width: 25,
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: todos[index].isCompleted == false ? ()async{
                                         await showModal(
                                           configuration: const FadeScaleTransitionConfiguration(
                                               transitionDuration: Duration(milliseconds: 400)
                                           ),
                                            context: context,
                                            builder: (BuildContext context) {
                                             updateTaskController.text = todos[index].title;
                                              return StatefulBuilder(
                                                builder: (BuildContext context, void Function(void Function()) setState) {
                                                  return TaskDialogBox(
                                                    controller: updateTaskController,
                                                    onChanged: (val){ setState(() {});},
                                                    suffixIcon: updateTaskController.text.isEmpty ? null :
                                                    GestureDetector(
                                                        onTap: (){
                                                          setState((){
                                                            updateTaskController.clear();
                                                          });
                                                        },
                                                        child: Icon(CupertinoIcons.multiply_circle, color: Colors.black,)),
                                                    onFieldSubmitted: (val){
                                                      if(val.trim().isEmpty){
                                                        return SnackShow.showFailure(context, 'required');
                                                      }else{
                                                        final updateTask = ToDo(
                                                            title: updateTaskController.text.trim(),
                                                            isCompleted: todos[index].isCompleted,
                                                            dateTime: DateFormat('d LLL, yyyy').format(DateTime.parse(DateTime.now().toString()))
                                                        );
                                                        final res =  ref.read(addTaskProvider.notifier).update(index,updateTask);
                                                        if(res == 'updated'){
                                                          Navigator.of(context).pop();
                                                          SnackShow.showSuccess(context, 'Task Updated');
                                                        }
                                                      }
                                                    },
                                                  );
                                                },
                                              );
                                              },
                                          );
                                          } : null,
                                        icon: Icon(Icons.edit,
                                          color: todos[index].isCompleted == true ? Colors.grey : Colors.green,)),
                                    const VerticalDivider(
                                      color: Colors.white,
                                      width: 25,
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: (){
                                          final res =ref.read(addTaskProvider.notifier).remove(todos[index]);
                                          if(res == 'deleted'){
                                            SnackShow.showSuccess(context, 'Task Deleted');
                                          }
                                          }, icon: Icon(Icons.delete, color: Colors.red,)),
                                  ],
                                ),
                              ),
                            ),
                          );
                    }),
                  ),
                ],
              ),
            ),

        floatingActionButton: isFab ? FloatingActionButton.extended(
          elevation: 0,
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
                      return TaskDialogBox(
                        controller: taskController,
                        onChanged: (val){ setState(() {});},
                        suffixIcon: taskController.text.isEmpty ? null :
                        GestureDetector(
                            onTap: (){
                              setState((){
                                taskController.clear();
                              });
                            },
                            child: Icon(CupertinoIcons.multiply_circle, color: Colors.black,)),
                        onFieldSubmitted: (val){
                          if(val.trim().isEmpty){
                            return SnackShow.showFailure(context, 'required');
                          }else{
                            final newTask = ToDo(
                                title: taskController.text.trim(),
                                isCompleted: false,
                                dateTime: DateFormat('d LLL, yyyy').format(DateTime.parse(DateTime.now().toString()))
                            );

                            final res =  ref.read(addTaskProvider.notifier).add(newTask);
                            if(res == 'Task Added'){
                              SnackShow.showSuccess(context, 'New Task Added');
                              Navigator.pop(context);
                              taskController.clear();
                            }
                          }
                        },
                      );
                    },
                  );
              },

            );
          },
          extendedPadding: EdgeInsets.symmetric(horizontal: 8.0),
          label: Text('add task', style: TextStyle(letterSpacing: 0),),
          icon: Icon(Icons.add),
    ) : null,
    );
  }
}
