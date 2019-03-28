import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayChargingBloc extends Bloc {
  final _visibleController = BehaviorSubject<bool>.seeded(false);
  final _visualizeController = PublishSubject<bool>();

  final _chargeCompleted = BehaviorSubject<bool>.seeded(false);
  final _completeChargeController = PublishSubject<void>();

  MerpayChargingBloc() {
    _visualizeController.listen((_val) => _visibleController.add(_val));

    _completeChargeController.listen((_) => _chargeCompleted.add(true));
  }

  ValueObservable<bool> get visible => _visibleController;
  Sink<bool> get visualize => _visualizeController.sink;

  ValueObservable<bool> get chargeCompleted => _chargeCompleted;
  Sink<void> get completeCharge => _completeChargeController;

  @override
  void dispose() async {
    await _visibleController.close();
    await _visualizeController.close();
  }
}
