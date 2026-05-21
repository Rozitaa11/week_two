import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_weather_app/bloc/weather_event.dart';
import 'package:flutter/material.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  final controller = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter city"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                context.read<WeatherBloc>().add(FetchWeather(controller.text));
              },
              child: Text("Get Weather"),
            ),

            SizedBox(height: 20),

            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                }

                if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(state.weather.city),
                      Text("${state.weather.temperature} °C"),
                      Text(state.weather.condition),
                    ],
                  );
                }

                if (state is WeatherError) {
                  return Text(state.message);
                }

                return Text("Search weather");
              },
            ),
          ],
        ),
      ),
    );
  }
}
