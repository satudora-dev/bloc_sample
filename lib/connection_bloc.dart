import 'package:bloc_provider/bloc_provider.dart';
import './counter_bloc.dart';
import './even_counter_bloc.dart';

class ConnectionBloc extends Bloc{
  CounterBloc _counter;
  EvenCounterBloc _evenCounter;

  ConnectionBloc(){
    _counter=CounterBloc();
    _evenCounter=EvenCounterBloc();
    _counter.count.listen((_v)=>_evenCounter.increment.add(_v));
  }

  @override
  void dispose() {
    _counter.dispose();
    _evenCounter.dispose();
  }

  CounterBloc get counterBloc => _counter;
  EvenCounterBloc get evenCounterBloc => _evenCounter;
}