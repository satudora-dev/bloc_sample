import '../Calendar/CalendarScreen.dart';
import 'package:flutter/material.dart';

class GoToCalendarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text("カレンダー"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarScreen()),
          );
          /*
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CalendarScreen()));
                    */
        });
  }
}
