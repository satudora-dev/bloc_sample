import './counter_bloc.dart';
import './reverse_counter_bloc.dart';

class AppBloc{
  CounterBloc _counterBloc;
  ReverseCounterBloc _reverseCounterBloc;

  AppBloc(){
    _counterBloc=CounterBloc();
    _reverseCounterBloc=ReverseCounterBloc();
    _counterBloc.counter$.listen((String str){_reverseCounterBloc.change.add(str);});
  }

  CounterBloc get counterBloc{return _counterBloc;}
  ReverseCounterBloc get reverseCounterBloc{return _reverseCounterBloc;}
}