import 'package:bloc_weather_app/bloc/weather_bloc.dart';
import 'package:bloc_weather_app/repository/weather_repository.dart';
import 'package:bloc_weather_app/screens/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repo = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => WeatherBloc(repo),
        child: WeatherPage(),
      ),
    );
  }
}
