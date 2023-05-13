import 'package:flutter/material.dart';
class TaskDialogBox extends StatefulWidget {
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;

  TaskDialogBox({
    this.controller,
    this.onFieldSubmitted
  });

  @override
  State<TaskDialogBox> createState() => _TaskDialogBoxState();
}

class _TaskDialogBoxState extends State<TaskDialogBox> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState){
          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
            ),
            alignment: Alignment.bottomCenter,
            content: TextFormField(
              maxLength: 30,
              controller: widget.controller,
              onFieldSubmitted: widget.onFieldSubmitted,
              decoration: InputDecoration(
                labelText: 'Task Name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          );
        });
  }
}
