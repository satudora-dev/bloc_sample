import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CounterBloc{
  int _counter=0;

  final _counter$=BehaviorSubject<int>.seeded(0);
  final _incrementController=StreamController<void>();

  CounterBloc(){
    //sink時の処理を追加
    _incrementController.stream.listen((void _){_counter$.add(_counter++);});
  }

  Sink<void> get increment{return _incrementController.sink;}

  Stream<int> get counter${return _counter$.stream;}

  void dispose(){
    _incrementController.close();
    _counter$.close();
  }
}