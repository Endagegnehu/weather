import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data/model/weather.dart';

void main() {
  runApp(SearchWeather());
}

class SearchWeather extends StatefulWidget {
  @override
  _SearchWeatherState createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather> {
  String country;
  @override
  void initState() {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeatherForLocation(null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Container();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildContainer(context, state.weather);
          }
        },
      ),
    );
  }

  Stack buildContainer(BuildContext context, Weather weather) {
    if (weather.mainWeather == 'Thunderstorm') {
      return buildStack(weather,
          'https://i.pinimg.com/originals/06/1e/7d/061e7d436de6aec2e3f1df3f40660c3e.gif?raw=true');
    } else if (weather.mainWeather == 'Drizzle') {
      return buildStack(weather, 'https://i.gifer.com/Rhhw.gif?raw=true');
    } else if (weather.mainWeather == 'Rain') {
      return buildStack(weather,
          'https://media3.giphy.com/media/l0Iy5fjHyedk9aDGU/giphy.gif?raw=true');
    } else if (weather.mainWeather == 'Snow') {
      return buildStack(weather,
          'https://66.media.tumblr.com/b54b3b98a894c940a966c29a64f71219/tumblr_pmu8ukhf381toamj8o1_640.gif?raw=true');
    } else if (weather.mainWeather == 'Clear') {
      return buildStack(weather,
          'https://www.beardsfuneralchapel.com/wp2/wp-content/uploads/2019/06/blue-sky-1.jpg?raw=true');
    } else {
      return buildStack(weather,
          'https://thumbs.gfycat.com/HairyCraftyJay-size_restricted.gif?raw=true');
    }
  }

  Stack buildStack(Weather weather, String url) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.asset(
          'assets/addisabeba.jpg',
          width: width,
          height: hight / 1.6,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: hight / 2.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  weather.cityName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  // Display the temperature with 1 decimal place
                  "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  width: 70,
                ),
                // Icon(weather.icon, color: Colors.black,),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hight / 1.8),
          child: Container(
            color: Colors.blueGrey,
            width: width,
            height: hight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(1),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day2} °C ${weather.main2Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day2icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(2),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day3} °C ${weather.main3Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day3icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(3),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day4} °C ${weather.main4Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day4icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(4),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day5} °C ${weather.main5Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day5icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(5),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day6} °C ${weather.main6Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day6icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDate(6),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${weather.day7} °C ${weather.main7Weather}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'http://openweathermap.org/img/wn/${weather.day7icon}@2x.png',
                        width: 40,
                      ),
                    ],
                  ),
                  Divider(height: 4, color: Colors.black),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  String getDate(int num) {
    DateTime date = DateTime.now();
    var newDate = DateTime(date.year, date.month, date.day + num);
    String dateFormat = DateFormat('EEEE').format(newDate);
    return dateFormat;
  }

  Center buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  submitCityName(String value) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(value));
  }
}
