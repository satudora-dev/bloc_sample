import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayChargingBloc extends Bloc {

  final _chargeCompleted = BehaviorSubject<bool>.seeded(false);
  final _completeChargeController = PublishSubject<void>();

  MerpayChargingBloc() {
    _completeChargeController.listen((_) => _chargeCompleted.add(true));
  }

  ValueObservable<bool> get chargeCompleted => _chargeCompleted;
  Sink<void> get completeCharge => _completeChargeController;

  @override
  void dispose() async {

    await _chargeCompleted.close();
    await _completeChargeController.close();
  }
}
