import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './connection_bloc.dart';
import './merpay_modal/merpay_modal_bloc.dart';
import './merpay_modal/bloc_merpay_view.dart';

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
        body: Center(
          child: Row(
            children: <Widget>[
              StreamBuilder<int>(
                stream: connectionBloc.counterBloc.count,
                initialData: connectionBloc.counterBloc.count.value,
                builder: (context, snap) => Text(
                      'count: ${snap.data}',
                      style: Theme.of(context).textTheme.title,
                    ),
              ),
              StreamBuilder<int>(
                stream: connectionBloc.evenCounterBloc.count,
                initialData: connectionBloc.evenCounterBloc.count.value,
                builder: (context, snap) => Text(
                      'count: ${snap.data}',
                      style: Theme.of(context).textTheme.title,
                    ),
              ),
              BlocProviderTree(
                blocProviders: [
                  BlocProvider<MerpayModalBloc>(
                    creator: (context, _bag) => MerpayModalBloc(),
                  ),
                ],
                child: BlocMerpayView(),
              ),
            ],
          ),
        ),
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
