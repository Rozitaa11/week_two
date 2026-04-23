import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:week_six/models/task.dart';
import 'package:week_six/utils/app_str.dart';
import 'package:week_six/views/home/components/date_time_selection.dart';
import 'package:week_six/views/home/components/rep_TextField.dart';
import 'package:week_six/views/home/widget/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  final TextEditingController titleTaskController;
  final TextEditingController descriptionTaskControlle;
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskControlle,
    this.task,
  });
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //top side texts
                _buildTopSideText(textTheme),
                _buildMainTaskViewActivity(textTheme),

                // task title text field
                RepTextField(
                  controller: widget.titleTaskController,
                  isForDescription: false,
                ),
                SizedBox(height: 10),
                RepTextField(
                  controller: widget.descriptionTaskControlle,
                  isForDescription: false,
                ),
                //for time selection
                DateTimeSelectionWidget(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SizedBox(
                        height: 200,
                        child: TimePickerWidget(
                          onChange: (_, _) {},
                          dateFormat: 'hh:mm a',
                          onConfirm: (DateTime, _) {},
                        ),
                      ),
                    );
                  },
                  title: 'Time',
                ),
                DateTimeSelectionWidget(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030, 4, 5),
                    );
                    if (date != null) {
                      setState(() {
                        selectedDate = date.toLocal().toString().split(' ')[0];
                      });
                    }
                  },
                  title: AppStr.dateString,
                  value: selectedDate,
                ),
                _buildBottonSideButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottonSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //delete current taks
          MaterialButton(
            onPressed: () {},
            minWidth: 150,

            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Row(
              children: const [
                Icon(Icons.close, color: Colors.blue),
                SizedBox(width: 5),
                Text(AppStr.deleteTask, style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),

          //add task to the list
          MaterialButton(
            onPressed: () {},
            minWidth: 150,

            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Text(
              AppStr.addTaskString,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  ///main activity of task view
  Widget _buildMainTaskViewActivity(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      // height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 70, child: Divider(thickness: 1, color: Colors.grey)),
          RichText(
            text: TextSpan(
              text: AppStr.addNewTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppStr.taskStrnig,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(width: 70, child: Divider(thickness: 1, color: Colors.grey)),
        ],
      ),
    );
  }
}
