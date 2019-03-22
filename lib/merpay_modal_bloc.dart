import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayModalBloc extends Bloc{
  final _phaseController = BehaviorSubject<int>.seeded(0);

  @override
  void dispose() {
          
  }
}