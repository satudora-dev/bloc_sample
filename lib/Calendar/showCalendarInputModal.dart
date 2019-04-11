import 'package:flutter/material.dart';
import './CalendarInputForm.dart';

void showCalendarInputModal(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CalendarInputModal());
}

class CalendarInputModal extends StatefulWidget {
  @override
  _CalendarInputModalState createState() => new _CalendarInputModalState();
}

class _CalendarInputModalState extends State<CalendarInputModal> {
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
                    children: <Widget>[CalendarInputForm()]))));
  }
}
