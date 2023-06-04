import 'package:flutter/material.dart';

class TaskDialogBox extends StatefulWidget {
  TextEditingController? controller;
  Function(String)? onFieldSubmitted;
  Widget? suffixIcon;
  void Function(String)? onChanged;

  TaskDialogBox({
    this.controller,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.onChanged
  });

  @override
  State<TaskDialogBox> createState() => _TaskDialogBoxState();
}

class _TaskDialogBoxState extends State<TaskDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
      ),
      content: TextFormField(
        maxLength: 30,
        controller: widget.controller,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          labelText: 'task',
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }
}
