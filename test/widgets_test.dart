import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data/fetch_weather_and_date.dart';
import 'package:weather/screens/weathersearch.dart';

void main() {
  group('Widget test', () {
    testWidgets('ProgressIndicator test...', (WidgetTester widgetTester) async {
      await widgetTester.runAsync(
        () async => await widgetTester.pumpWidget(
          BlocProvider(
            create: (context) => WeatherBloc(FetchWeatherDataFromAPI()),
            child: MaterialApp(
              home: SearchWeather(),
            ),
          ),
        ),
      );
    });
  });
}
