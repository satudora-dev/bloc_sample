import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './connection_bloc.dart';
import './merpay_modal/merpay_modal_bloc.dart';
import './merpay_modal/bloc_merpay_view.dart';

import './Model/HealthProfile.dart';
import './Repository/HealthProfileRepository.dart';

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
    final healthProfileRepository = HealthProfileRepository();
    healthProfileRepository.reset();
    healthProfileRepository.save(HealthProfile(DateTime.now(), "60", "36.0"));
    healthProfileRepository.save(HealthProfile(DateTime.now(), "70", "37.0"));
    healthProfileRepository.save(HealthProfile(DateTime.now(), "80", "38.0"));
    healthProfileRepository.getAllHealthProfile();
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
