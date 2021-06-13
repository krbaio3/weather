import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as $http;
import 'package:weather/models/weather.model.dart';

class WeatherService {
  //TODO sacar a un dotEnv
  final String _apiKey = 'c8c0e119e7b96af5d946daa918f18e54';
  final String _startUrl = 'api.openweathermap.org';
  final String _iconUrl = 'openweathermap.org';
  final String _endUrl = 'weather';
  final String _language = 'es';
  final String _apiVersion = '2.5';

  Future<Weather> _processResponse(Uri url) async {
    final response = await $http.get(url);
    final decodedData = json.decode(response.body);
    final weather = Weather.fromJsonMap(decodedData);
    return weather;
  }

  Future<Weather?> getWeatherData() async {
    final url = Uri.https(
      '$_startUrl',
        'data/$_apiVersion/$_endUrl',
        {
          "q": 'Madrid',
          "appid": _apiKey,
          "units": "metric",
          "lang": _language
        }
    );

    try {
       return await _processResponse(url);
    } catch(e) {
      return null;
    }
  }

  String getIconWeatherData(String icon) =>
  'https://$_iconUrl/img/wn/$icon@2x.png';


}
