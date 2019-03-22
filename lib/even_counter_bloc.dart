import 'package:rxdart/rxdart.dart';
import 'package:bloc_provider/bloc_provider.dart';

class EvenCounterBloc implements Bloc{
  final _countController=BehaviorSubject<int>.seeded(0);
  final _incrementController=PublishSubject<void>();

  EvenCounterBloc(){
    _incrementController
      .scan<int>((sum,_v,_i)=>sum+2,0)
      .pipe(_countController);//_counterControllerにstreamを流す?
  }

  ValueObservable<int> get count=>_countController;
  Sink<void> get increment=>_incrementController.sink;

  @override
  void dispose() async{
    await _incrementController.close();
    await _countController.close();
  }
}