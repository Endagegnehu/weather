import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/model/weather.dart';
import 'package:weather/data/networking.dart';

abstract class FetchWeatherData {
  Future<Weather> fetchWeather(String cityName);
  Future fetchLocation();
}

class FetchWeatherDataFromAPI implements FetchWeatherData {
  @override
  Future<Weather> fetchWeather(String cityName) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=539033bedf5c563c554d7e3b5ebe9d6f';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return Weather(
      cityName: weatherData['name'],
      temperatureCelsius: weatherData['main'][0]['temp'],
      icon: weatherData['weather'][0]['icon'],
      mainWeather: weatherData['weather'][0]['main'],
    );
  }

  Future<Weather> fetchWeatherLatLog(double lat, double log) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&units=metric&appid=539033bedf5c563c554d7e3b5ebe9d6f';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return Weather(
      cityName: weatherData['name'],
      temperatureCelsius: weatherData['main']['temp'].toDouble(),
      icon: weatherData['weather'][0]['icon'],
      mainWeather: weatherData['weather'][0]['main'],
    );
  }

  Future<Weather> fetchWeatherOfDays(double lat, double log) async {
    var url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$log&units=metric&%20exclude=hourly,daily&appid=539033bedf5c563c554d7e3b5ebe9d6f';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    final coordinates = new Coordinates(lat, log);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return Weather(
      cityName: first.adminArea,
      temperatureCelsius: weatherData['current']['temp'].toDouble(),
      icon: weatherData['current']['weather'][0]['icon'],
      mainWeather: weatherData['current']['weather'][0]['main'],
      day2: weatherData['daily'][0]['temp']['day'],
      day2icon: weatherData['daily'][0]['weather'][0]['icon'],
      main2Weather: weatherData['daily'][0]['weather'][0]['description'],
      day3: weatherData['daily'][1]['temp']['day'],
      day3icon: weatherData['daily'][1]['weather'][0]['icon'],
      main3Weather: weatherData['daily'][1]['weather'][0]['description'],
      day4: weatherData['daily'][2]['temp']['day'],
      day4icon: weatherData['daily'][2]['weather'][0]['icon'],
      main4Weather: weatherData['daily'][2]['weather'][0]['description'],
      day5: weatherData['daily'][3]['temp']['day'],
      day5icon: weatherData['daily'][3]['weather'][0]['icon'],
      main5Weather: weatherData['daily'][3]['weather'][0]['description'],
      day6: weatherData['daily'][4]['temp']['day'],
      day6icon: weatherData['daily'][4]['weather'][0]['icon'],
      main6Weather: weatherData['daily'][4]['weather'][0]['description'],
      day7: weatherData['daily'][5]['temp']['day'],
      day7icon: weatherData['daily'][5]['weather'][0]['icon'],
      main7Weather: weatherData['daily'][5]['weather'][0]['description'],
    );
  }

  @override
  Future fetchLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      return fetchWeatherOfDays(latitude, longitude);
    } catch (e) {
      print(e);
    }
  }
}
