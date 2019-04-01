import 'package:flutter/material.dart';

import 'package:bloc_sample/charge_bloc.dart';

class BlocProvider extends InheritedWidget {
  final ChargeBloc bloc;

  BlocProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ChargeBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
}
