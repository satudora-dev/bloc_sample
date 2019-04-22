import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './connection_bloc.dart';
import './merpay_modal/go_to_merpay_trace_button.dart';
import './Calendar/GoToCalendarButton.dart';

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
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Bloc Test')),
        body: Column(children: <Widget>[
          GoToMerpayTraceButton(),
          ButtonToCalendarScreen()
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            connectionBloc.counterBloc.increment.add(null);
          },
        ),
      ),
    );
  }
}
