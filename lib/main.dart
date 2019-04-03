import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './connection_bloc.dart';
import './merpay_modal/merpay_modal_bloc.dart';
import './merpay_modal/bloc_merpay_view.dart';
import './merpay_modal/merpay_modal_animation_bloc.dart';

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
        body: BlocProviderTree(
          blocProviders: [
            BlocProvider<MerpayModalBloc>(
              creator: (context, _bag) => MerpayModalBloc(),
            ),
            BlocProvider<MerpayModalAnimationBloc>(
              creator: (context, _bag) => MerpayModalAnimationBloc(),
            ),
          ],
          child: BlocMerpayView(),
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
