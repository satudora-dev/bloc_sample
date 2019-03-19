import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ReverseCounterBloc{
  final _counter$=BehaviorSubject<String>.seeded('First State');
  final _changeController=StreamController<String>();

  ReverseCounterBloc(){
    _changeController.stream.listen((String str){
      if(str=='Left')str='Right';
      else str='Left';
      _counter$.add(str);
    });
  }

  Sink<String> get change{return _changeController.sink;}
  Stream<String> get counter${return _counter$.stream;}

  void dispose(){
    _changeController.close();
    _counter$.close();
  }
}