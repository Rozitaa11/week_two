import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_six/data/hive_data_store.dart';
import 'package:week_six/models/task.dart';
import 'package:week_six/views/home/widget/home_view.dart';

Future<void> main() async {
  //intialize hive before running the app

  await Hive.initFlutter();

  //registering the adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  //open the box
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);
  // this step is not necessary but it is good to have it in the main function to avoid any issues later on when we try to access the box before it is opened.
  // delete the data froom  previous day
  box.values.forEach((task) {
    if (task.createdAtDate.day != DateTime.now().day) {
      task.delete();
    } else {}
  });
  runApp(BaseWidget(child: const MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('BaseWidget not found in context');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(color: Colors.white, fontSize: 21),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
          headlineMedium: TextStyle(color: Colors.black, fontSize: 17),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}
