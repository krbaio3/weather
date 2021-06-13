import 'package:rxdart/rxdart.dart';
import 'package:weather/models/weather.model.dart';

class WeatherBloc {

  final _weatherCtrl = BehaviorSubject<Weather>();

  Stream<Weather> get weatherStream => _weatherCtrl.stream;

  Function(Weather) get changeWeather => _weatherCtrl.sink.add;

  Weather get weather => _weatherCtrl.value;

  void dispose(){
    _weatherCtrl.close();
  }

  reset() {
    changeWeather(new Weather());
  }
}
