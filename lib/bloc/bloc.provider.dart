import 'package:flutter/material.dart';
import 'package:weather/bloc/weather.bloc.dart';
export 'package:weather/bloc/weather.bloc.dart';

class BlocProvider extends InheritedWidget {
  static BlocProvider? _instance;

  factory BlocProvider({ Key? key, Widget? child }) {
    if (_instance == null) {
      _instance = new BlocProvider._internal(key: key, child: child);
    }

    return _instance as BlocProvider;
  }

  BlocProvider._internal({ Key? key, Widget? child }) : super(key: key, child: child as Widget);

  final WeatherBloc _weatherBloc = WeatherBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static WeatherBloc weatherBloc(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BlocProvider>()!._weatherBloc;
}
