part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherByCityName extends WeatherEvent {
  final String cityName;
  GetWeatherByCityName(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetWeatherForLocation extends WeatherEvent {
  @override
  List<Object> get props => [];
}
