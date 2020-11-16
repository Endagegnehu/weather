import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/networking.dart';

void main() {
  test('Get Json', () async {
    var url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=8.9806&lon=38.7578&units=metric&%20exclude=hourly,daily&appid=539033bedf5c563c554d7e3b5ebe9d6f';
    NetworkHelper networkHelper = NetworkHelper(url);
    var error;
    var response;
    response = await networkHelper.getData().then((value) => value.fold(
          (l) => l,
          (r) => r,
        ));
    expect(response, 200);
  });
}
