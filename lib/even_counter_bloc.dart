import 'package:rxdart/rxdart.dart';
import 'package:bloc_provider/bloc_provider.dart';

class EvenCounterBloc implements Bloc{
  final _countController=BehaviorSubject<int>.seeded(0);
  final _incrementController=PublishSubject<int>();

  EvenCounterBloc(){
    _incrementController.listen((_v)=>_countController.add(_v*2));
  }

  ValueObservable<int> get count=>_countController;
  Sink<int> get increment=>_incrementController.sink;

  @override
  void dispose() async{
    await _incrementController.close();
    await _countController.close();
  }
}