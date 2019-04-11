import '../Calendar/CalendarSelectScreen.dart';
import 'package:flutter/material.dart';

class ButtonToCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text("カレンダー選択画面へ"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarSelectScreen()),
          );
          /*
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CalendarScreen()));
                    */
        });
  }
}
