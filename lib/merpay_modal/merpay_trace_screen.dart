import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'merpay_modal_bloc.dart';
import 'bloc_merpay_view.dart';
import 'merpay_modal_animation_bloc.dart';

class MerpayTraceScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('メルペイトレース')),
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
        ));
  }
}
