import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response;
    try {
      response = await http.get(url);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
