import 'package:flutter/material.dart' show BorderRadius, BoxDecoration, BuildContext, Checkbox, Colors, Container, EdgeInsets, Icons, Padding, Row, StatelessWidget, Text, TextDecoration, TextStyle, Widget;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart'; // Import Key from the correct location


// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  void Function(BuildContext)? deleteFunction; // Use 'void Function' for deleteFunction

  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteFunction?.call(context),
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskComplete ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
