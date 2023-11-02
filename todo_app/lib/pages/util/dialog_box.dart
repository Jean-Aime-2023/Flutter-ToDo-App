import 'package:flutter/material.dart';
import 'package:todo_app/pages/util/myButton.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // ignore: prefer_const_constructors
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Add a new task"),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              myButton(text: "Save", onPressed: onSave),
              const SizedBox(width: 8),
              myButton(text: "Cancel", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}