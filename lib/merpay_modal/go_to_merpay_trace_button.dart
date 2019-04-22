import 'package:flutter/material.dart';
import 'merpay_trace_screen.dart';

class GoToMerpayTraceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text("メルペイトレース"),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MerpayTraceScreen())));
  }
}
