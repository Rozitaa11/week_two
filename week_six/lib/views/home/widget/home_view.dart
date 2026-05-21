import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:week_six/models/task.dart';
import 'package:week_six/utils/app_str.dart';
import 'package:week_six/utils/constant.dart';
import 'package:week_six/views/home/components/task_widget.dart';

import 'package:week_six/views/home/components/fab.dart';
import 'package:week_six/extensions/space_exs.dart';
import 'package:week_six/views/home/components/home_app_bart.dart';
import 'package:week_six/views/home/components/slider_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final List<int> testings = [1];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      //FAB
      floatingActionButton: const Fab(),
      body: SliderDrawer(
        key: drawerKey,
        isDraggable: false,
        animationDuration: 1000,
        //drawer
        slider: CustomDrawer(),
        appBar: HomeAppBar(drawerKey: drawerKey),

        //mainBody
        child: _buildHomeBody(textTheme),
      ),
    );
  }

  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,

      child: Column(
        children: [
          //app bar
          Container(
            //divider
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //progress indicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    value: 1 / 3,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
                25.w,
                //top layout info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: textTheme.displayLarge, AppStr.mainTitle),
                    3.h,
                    Text('1 of 3 Tasks', style: textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(thickness: 1, indent: 100),
          ),
          //task list
          Expanded(
            child: testings.isNotEmpty
                //task list is not empty
                ? ListView.builder(
                    itemCount: testings.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          // Handle the dismissal action here
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline, color: Colors.grey),
                            8.w,
                            Text(
                              AppStr.deletedTask,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        key: Key(index.toString()),
                        child: TaskWidget(
                          // this is only for testing purpose, we will pass the actual task object here
                          // we will load tasks from db later one
                          task: Task(
                            id: '1',
                            title: 'Home Task',
                            subTitle: 'Cleaning the room',
                            createdAtTime: DateTime.now(),
                            createdAtDate: DateTime.now(),
                            isCompleted: false,
                          ),
                        ),
                      );
                    },
                  )
                :
                  // task list is empty
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(lottieURL, animate: true),
                        ),
                      ),
                      FadeInUp(from: 30, child: Text(AppStr.doneAllTask)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
