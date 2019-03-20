import 'package:flutter/material.dart';

import './app_bloc.dart';

class BlocProvider extends InheritedWidget{
  final AppBloc bloc;

  BlocProvider({Key key,this.bloc,child}):super(key: key,child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static AppBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
  }
}