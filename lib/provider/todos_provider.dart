import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../main.dart';
import '../model/todos.dart';

final addTaskProvider = StateNotifierProvider<TodosProvider, List<ToDo>>(
    (ref) => TodosProvider(ref.watch(box)));

class TodosProvider extends StateNotifier<List<ToDo>> {
  TodosProvider(List<ToDo> initialState) : super(initialState);

  //add task
  String add(ToDo toDo) {
    final newTask = ToDo(
        title: toDo.title,
        isCompleted: toDo.isCompleted,
        dateTime: toDo.dateTime);
    final box = Hive.box<ToDo>('task').add(newTask);
    state = [...state, newTask];
    return 'Task Added';
  }

//delete task
  String remove(ToDo deleteTask) {
    deleteTask.delete();
    state.remove(deleteTask);
    state = state.where((task) => task != deleteTask).toList();
    // state = [...state];
    return 'deleted';
  }

// update task
  String update(int index,ToDo updateTodo) {
    state[index] = updateTodo;
    final updateTask = ToDo(
        title: updateTodo.title,
        isCompleted: updateTodo.isCompleted,
        dateTime: updateTodo.dateTime);
    final box = Hive.box<ToDo>('task').putAt(index, updateTask);
    state = List.from(state)..[index] = updateTask;
    // state = [...state];
    return 'updated';
  }


  //checkbox update
  bool checkUpdate(ToDo checkBox) {
    checkBox.isCompleted = !checkBox.isCompleted;
    checkBox.save();
    state = [...state];
    return checkBox.isCompleted;
  }
}
