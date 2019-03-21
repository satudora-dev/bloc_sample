import 'package:rxdart/rxdart.dart';
import 'package:bloc_provider/bloc_provider.dart';

class CounterBloc implements Bloc{
  final _countController=BehaviorSubject<int>.seeded(0);
  final _incrementController=PublishSubject<void>();

  CounterBloc(){
    _incrementController
      .scan<int>((sum,_v,_i)=>sum+1,0)
      .pipe(_countController);
  }

  ValueObservable<int> get count=>_countController;
  Sink<void> get increment=>_incrementController.sink;

  @override
  void dispose() async{
    await _incrementController.close();
    await _countController.close();
  }
}