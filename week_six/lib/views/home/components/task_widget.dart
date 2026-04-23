import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_six/models/task.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to tak view to see task details
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.task.isCompleted
              ? const Color.fromARGB(183, 194, 180, 222)
              : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(215, 173, 165, 165),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              // Handle tap event
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 131, 134, 225),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 197, 197, 213),
                  width: .8,
                ),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 5.0),
            child: Text(
              widget.task.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description',
                style: TextStyle(
                  color: Color.fromARGB(255, 229, 221, 221),
                  fontWeight: FontWeight.w300,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),

                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'MM/dd/yyyy',
                        ).format(widget.task.createdAtDate),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
