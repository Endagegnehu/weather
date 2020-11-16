import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/data/fetch_weather.dart';
import 'package:weather/data/model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherData fetchWeartherData;

  WeatherBloc(this.fetchWeartherData) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await fetchWeartherData.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } catch (e) {
        print(e);
      }
    } else if (event is GetWeatherForLocation) {
      try {
        final weather = await fetchWeartherData.fetchLocation();
        yield WeatherLoaded(weather);
      } catch (e) {
        print(e);
      }
    }
  }
}
