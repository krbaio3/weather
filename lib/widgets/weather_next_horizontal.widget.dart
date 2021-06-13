import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather_next.model.dart';
import 'package:weather/service/weather.service.dart';

class WeatherNextHorizontal extends StatelessWidget {
  final WeatherNext weatherNext;

  // TODO: Implementar la paginacion
  // final _pageCtrl = PageController(initialPage: 1, viewportFraction: 0.3);
  //
  // final Function nextPage;

  WeatherNextHorizontal({Key? key, required this.weatherNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    // _pageCtrl.addListener(() {
    //   if (_pageCtrl.position.pixels >=
    //       _pageCtrl.position.maxScrollExtent - 200) {
    //     nextPage();
    //   }
    // });

    return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
          pageSnapping: false,
          // controller: _pageCtrl,
          itemCount: weatherNext.list!.length,
          itemBuilder: (BuildContext context, int i) =>
              _card(context, weatherNext.list![i]),
        ));
  }

  Widget _card(BuildContext context, ListElement nextWeather) {
    nextWeather.id = UniqueKey().toString();

    return Container(
      // margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: nextWeather.id.toString(),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(
                    'https://openweathermap.org/img/wn/${nextWeather.weather![0].icon}@2x.png'),
                fit: BoxFit.contain,
                height: 120.0,
              ),
            ),
          ),
          Text(_setWeekDay(nextWeather.dt!),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.teal[200], fontSize: 15.0)),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${nextWeather.main!.tempMax!.toStringAsFixed(0)}°',
                  style: TextStyle(color: Colors.white60)),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${nextWeather.main!.tempMin!.toStringAsFixed(0)}°',
                style: TextStyle(color: Colors.white38),
              ),
            ],
          )
        ],
      ),
    );

    // TODO : Implementar pantalla de detalle tiempo Next Week
    // return GestureDetector(
    //   onTap: () => Navigator.pushNamed(context, 'detail', arguments: {}),
    //   child: card,
    // );
  }
}

String _setWeekDay(int dt) => WeekDay.values[
        (DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal().weekday - 1)]
    .toString()
    .split('.')[1];

enum WeekDay {
  Lunes,
  Martes,
  Miercoles,
  Jueves,
  Viernes,
  Sabado,
  Domingo,
}
