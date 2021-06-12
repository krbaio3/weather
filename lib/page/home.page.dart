import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Color.fromRGBO(15, 30, 55, 1),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: _onPressedSearch)
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _realTime(),
            Divider(
              color: Colors.black,
              indent: 10.0,
              endIndent: 10.0,
            ),
            _nextTime()
          ],
        ),
      )
    );
  }

  void _onPressedSearch() {
    print('Press me!');
  }

  Widget _realTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _realTimeData(),
        _realTimeIcon()
      ],
    );
  }

  Widget _realTimeData() {
    return Column(

      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('18'),
        Text('Madrid | Barcelona'),
        Text('Hoy'),
        Row(children: [
          Text('20'),
          Text('17'),
          Text('Humidity: 48')
        ],)

      ],
    );
  }

  Widget _realTimeIcon() {
    return Column(children: [Icon(Icons.wb_sunny)],);
  }

  Widget _nextTime() {
    return Row(
      children: [

            _nextTimeData()
          ],

    );
  }

  Widget _nextTimeData() {
    return Column(
      children: [
        Icon(Icons.wb_sunny),
        Text('Viernes'),
        Row(
          children: [Text('25'), Text('26')],
        )

      ],
    );
  }

}

