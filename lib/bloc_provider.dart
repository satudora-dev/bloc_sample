import 'package:flutter/material.dart';

import './counter_bloc.dart';

class BlocProvider extends InheritedWidget{
  final CounterBloc bloc;

  BlocProvider({Key key,this.bloc,child}):super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static CounterBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
  }
}