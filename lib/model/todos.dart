import 'package:hive/hive.dart';
part 'todos.g.dart';


@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  String dateTime;

  ToDo({
    required this.title,
    required this.isCompleted,
    required this.dateTime,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? '',
      dateTime: json['dateTime'] ?? '',
    );
  }
}
