part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  const WeatherLoadedState(this.weather);
  @override
  List<Object> get props => [];
}

class Errors extends WeatherState {
  @override
  List<Object> get props => [];
}
