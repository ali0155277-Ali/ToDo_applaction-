import 'package:flutter/material.dart';

class TaskColorListViwe extends StatefulWidget {
  final Function(Color)? onColorSelected;
  const TaskColorListViwe({super.key, this.onColorSelected});

  @override
  State<TaskColorListViwe> createState() => _TaskColorListViweState();
}

class _TaskColorListViweState extends State<TaskColorListViwe> {
  int selectedColor = -1;

  final List<MaterialColor> taskColors = [
    Colors.red,
    Colors.deepPurple,
    Colors.amber,
    Colors.deepOrange,
    Colors.green,
    Colors.pink,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              selectedColor = index;
              widget.onColorSelected?.call(taskColors[index]);
            });
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: taskColors[index],
            child: selectedColor == index
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
        ),
        itemCount: taskColors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
