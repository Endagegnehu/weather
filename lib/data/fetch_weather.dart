import 'package:dartz/dartz.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/model/weather.dart';
import 'package:weather/data/networking.dart';

abstract class FetchWeatherData {
  Future fetchLocation();
}

class FetchWeatherDataFromAPI implements FetchWeatherData {
  Future<Weather> fetchWeatherLatLog(double lat, double log) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&units=metric&appid=539033bedf5c563c554d7e3b5ebe9d6f';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    weatherData.fold(
        (errors) => null,
        (response) => Weather(
              cityName: response['name'],
              temperatureCelsius: response['main']['temp'].toDouble(),
              icon: response['weather'][0]['icon'],
              mainWeather: response['weather'][0]['main'],
            ));
  }

  Future<Either<Exception, dynamic>> fetchWeatherOfDays(
      double lat, double log) async {
    var url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$log&units=metric&%20exclude=hourly,daily&appid=539033bedf5c563c554d7e3b5ebe9d6f';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    final coordinates = new Coordinates(lat, log);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return weatherData.fold(
        (erros) => left(erros),
        (resonse) => right(Weather(
              cityName: first.adminArea,
              temperatureCelsius: resonse['current']['temp'].toDouble(),
              icon: resonse['current']['weather'][0]['icon'],
              mainWeather: resonse['current']['weather'][0]['main'],
              day2: resonse['daily'][0]['temp']['day'],
              day2icon: resonse['daily'][0]['weather'][0]['icon'],
              main2Weather: resonse['daily'][0]['weather'][0]['description'],
              day3: resonse['daily'][1]['temp']['day'],
              day3icon: resonse['daily'][1]['weather'][0]['icon'],
              main3Weather: resonse['daily'][1]['weather'][0]['description'],
              day4: resonse['daily'][2]['temp']['day'],
              day4icon: resonse['daily'][2]['weather'][0]['icon'],
              main4Weather: resonse['daily'][2]['weather'][0]['description'],
              day5: resonse['daily'][3]['temp']['day'],
              day5icon: resonse['daily'][3]['weather'][0]['icon'],
              main5Weather: resonse['daily'][3]['weather'][0]['description'],
              day6: resonse['daily'][4]['temp']['day'],
              day6icon: resonse['daily'][4]['weather'][0]['icon'],
              main6Weather: resonse['daily'][4]['weather'][0]['description'],
              day7: resonse['daily'][5]['temp']['day'],
              day7icon: resonse['daily'][5]['weather'][0]['icon'],
              main7Weather: resonse['daily'][5]['weather'][0]['description'],
            )));
  }

  @override
  Future fetchLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;
    return fetchWeatherOfDays(latitude, longitude);
  }
}
