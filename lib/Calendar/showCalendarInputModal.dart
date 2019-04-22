import 'package:flutter/material.dart';
import './CalendarInputForm.dart';

void showCalendarInputModal(BuildContext context, DateTime date) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CalendarInputModal(date));
}

class CalendarInputModal extends StatefulWidget {
  DateTime date;

  CalendarInputModal(this.date);

  @override
  _CalendarInputModalState createState() => new _CalendarInputModalState(date);
}

class _CalendarInputModalState extends State<CalendarInputModal> {

  DateTime date;

  _CalendarInputModalState(this.date);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
        child: Center(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[CalendarInputForm(date)]))));
  }
}
