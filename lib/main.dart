import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './connection_bloc.dart';
import './merpay_modal/merpay_trace_screen.dart';
import './Calendar/CalendarSelectScreen.dart';

void main() => runApp(
      BlocProviderTree(
        blocProviders: [
          BlocProvider<ConnectionBloc>(
            creator: (context, _bag) => ConnectionBloc(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Bloc Test')),
        body: Column(children: <Widget>[
          RaisedButton(
              child: Text("メルペイトレース"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MerpayTraceScreen()),
                );
              }),
          RaisedButton(
              child: Text("カレンダー"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarSelectScreen()),
                );
              })
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            connectionBloc.counterBloc.increment.add(null);
          },
        ));
  }
}
