import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: new Calendar(
          onSelectedRangeChange: (range) =>
              print("Range is ${range.item1}, ${range.item2}"),
          isExpandable: true,
          dayBuilder: (BuildContext context, DateTime day) {
            return new InkWell(
              onTap: () => print("OnTap ${day}"),
              child: new Container(
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black38)),
                child: new Text(
                  day.day.toString(),
                ),
              ),
            );
          },
        ));
  }
}
