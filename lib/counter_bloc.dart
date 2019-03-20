import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CounterBloc{

  final _counter$=BehaviorSubject<String>.seeded('Seed val');
  final _incrementController=StreamController<String>();

  CounterBloc(){
    //sinkにaddした場合の処理を追加
    _incrementController.stream.listen((String str){_counter$.add(str);});
  }

  Sink<String> get increment{return _incrementController.sink;}

  Stream<String> get counter${return _counter$.stream;}

  void dispose(){
    _incrementController.close();
    _counter$.close();
  }
}