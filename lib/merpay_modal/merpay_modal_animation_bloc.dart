import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayModalAnimationBloc extends Bloc {

  final _animationCompleted = BehaviorSubject<bool>.seeded(false);
  final _completeAnimationController = PublishSubject<void>();

  MerpayModalAnimationBloc() {
    _completeAnimationController.listen((_) => _animationCompleted.add(true));
  }

  ValueObservable<bool> get animationCompleted => _animationCompleted;
  Sink<void> get completeAnimation => _completeAnimationController;

  @override
  void dispose() async {

    await _animationCompleted.close();
    await _completeAnimationController.close();
  }
}
