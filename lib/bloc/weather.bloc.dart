import 'package:rxdart/rxdart.dart';
import 'package:weather/models/weather_next.model.dart';
import 'package:weather/models/weather.model.dart';

class WeatherBloc {
  final _weatherCtrl = BehaviorSubject<Weather>();
  final _weatherNextCtrl = BehaviorSubject<WeatherNext>();

  Stream<Weather> get weatherStream => _weatherCtrl.stream;
  Stream<WeatherNext> get weatherNextStream => _weatherNextCtrl.stream;

  Function(Weather) get changeWeather => _weatherCtrl.sink.add;
  Function(WeatherNext) get changeNextWeather => _weatherNextCtrl.sink.add;

  Weather get weather => _weatherCtrl.value;
  WeatherNext get weatherNext => _weatherNextCtrl.value;

  void dispose() {
    _weatherCtrl.close();
    _weatherNextCtrl.close();
  }

  reset() {
    changeWeather(new Weather());
    changeNextWeather(new WeatherNext());
  }
}
