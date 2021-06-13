import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/bloc/bloc.provider.dart';
import 'package:weather/page/home.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'), // Español
        ],
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
