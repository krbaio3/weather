import 'package:flutter/material.dart';
import 'package:weather/bloc/bloc.provider.dart';
import 'package:weather/models/weather_next.model.dart';
import 'package:weather/models/weather.model.dart';
import 'package:weather/service/weather.service.dart';
import 'package:weather/widgets/weather_next_horizontal.widget.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;
  bool isLoadedNext = false;
  late WeatherBloc _weatherBloc;

  @override
  Widget build(BuildContext context) {
    this._weatherBloc = BlocProvider.weatherBloc(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Weather'),
          backgroundColor: Color.fromRGBO(15, 30, 55, 1),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: _onPressedSearch)
          ],
        ),
        backgroundColor: Color.fromRGBO(15, 30, 55, 1),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _realTimeData(context),
              Divider(
                color: Colors.white60,
                indent: 10.0,
                endIndent: 10.0,
              ),
              _nextTimeData()
            ],
          ),
        ));
  }

  void _onPressedSearch() {
    print('Press me!');
  }

  Widget _realTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 20.0,
        ),
        Expanded(flex: 1, child: _weatherContent()),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
            flex: 1,
            child: _realTimeIcon(
                context, this._weatherBloc.weather.weather![0].icon!)),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }

  Widget _realTimeData(BuildContext context) {
    if (this.isLoaded) {
      return _realTime(context);
    }

    return FutureBuilder<Weather?>(
      future: WeatherService().getWeatherData(),
      builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.blueAccent)));
          case ConnectionState.done:
            break;
        }

        this.isLoaded = true;

        if (!snapshot.hasData) {
          return Text('No hay datos');
        }

        final data = snapshot.data!;

        _weatherBloc.changeWeather(data);

        return _realTime(context);
      },
    );
  }

  Widget _realTimeIcon(BuildContext context, String icon) {
    return Container(
      alignment: Alignment.centerRight,
      height: 150.0,
      child: Image(
        // loadingBuilder: (context, child, loadingProgress) => CircularProgressIndicator(),
        image: NetworkImage(WeatherService().getIconWeatherData(icon)),
        height: 150.0,
        fit: BoxFit.fitHeight,
        width: 100.0,
      ),
    );
  }

  Widget _nextTimeData() {
    if (this.isLoadedNext) {
      return WeatherNextHorizontal(weatherNext: this._weatherBloc.weatherNext);
    }

    return FutureBuilder<WeatherNext?>(
      future: WeatherService().getNextWeatherData(),
      builder: (BuildContext context, AsyncSnapshot<WeatherNext?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.white60)));
          case ConnectionState.done:
            break;
        }

        this.isLoadedNext = true;

        if (!snapshot.hasData) {
          return Text('No hay datos');
        }

        final data = snapshot.data!;

        _weatherBloc.changeNextWeather(data);

        return WeatherNextHorizontal(
            weatherNext: this._weatherBloc.weatherNext);
      },
    );
  }

  Widget _weatherContent() {
    final data = _weatherBloc.weather;

    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${data.main!.temp!.toStringAsFixed(0)}°',
            style: TextStyle(color: Colors.white, fontSize: 45.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(data.name!,
              style: TextStyle(color: Colors.teal[200], fontSize: 20.0)),
          Text(
            _setDay(data.dt!),
            style: TextStyle(color: Colors.white70, fontSize: 18.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                '${data.main!.tempMax!.toStringAsFixed(0)}°',
                style: TextStyle(color: Colors.white60),
              ),
              SizedBox(width: 3.0),
              Text(
                ' ${data.main!.tempMin!.toStringAsFixed(0)}°',
                style: TextStyle(color: Colors.white38),
              ),
              SizedBox(width: 3.0),
              Text(
                'Humidity: ${data.main!.humidity!.toStringAsFixed(0)}',
                style: TextStyle(color: Colors.blue[300]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

String _setDay(int dt) {
  // time local
  final String today = DateTime.now().day.toString();

  // time in UTC
  final String getDayWeather =
      DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal().day.toString();

  return (today == getDayWeather) ? 'Hoy' : getDayWeather;
}
