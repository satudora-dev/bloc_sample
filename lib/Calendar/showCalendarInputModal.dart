import 'package:flutter/material.dart';

void showCalendarInputModal(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return CalendarInputModal(); //遷移先
      },
      /*
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    */
    ),
  );
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
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Text("モーダルです"),
      FlatButton(
          child: Text("閉じる"), onPressed: () => Navigator.of(context).pop())
    ]));
  }
}
