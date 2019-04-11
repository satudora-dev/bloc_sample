import 'package:flutter/material.dart';
import '../Calendar/CalendarScreen.dart';
import '../Calendar/OriginalCalendarScreen.dart';

class CalendarSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: <Widget>[
          RaisedButton(
              child: Text("flutter_calendar"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalendarScreen()));
              }),
          RaisedButton(
              child: Text("オリジナルカレンダー"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OriginalCalendarScreen()));
              })
        ]));
  }
}
