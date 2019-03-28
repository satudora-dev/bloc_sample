import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayChargeBloc extends Bloc {
  final _visible = BehaviorSubject<bool>.seeded(false);
  final _visualizeController = PublishSubject<bool>();

  final _chargeAmount = BehaviorSubject<int>.seeded(0);
  final _chargeMoneyController = PublishSubject<int>();

  final _confirmed = BehaviorSubject<bool>.seeded(false);
  final _confirmController = PublishSubject<void>();

  MerpayChargeBloc() {
    _visualizeController.listen((_val) => _visible.add(_val));

    _chargeMoneyController.listen((_amount) => _chargeAmount.add(_amount));

    _confirmController.listen((_) => _confirmed.add(true));
  }

  ValueObservable<bool> get visible => _visible;
  Sink<bool> get visualize => _visualizeController.sink;

  ValueObservable<int> get chargeAmount => _chargeAmount;
  Sink<int> get chargeMoney => _chargeMoneyController.sink;

  ValueObservable<bool> get confirmed => _confirmed;
  Sink<void> get confirm => _confirmController.sink;

  @override
  void dispose() async {
    await _visible.close();
    await _visualizeController.close();
    await _chargeAmount.close();
    await _chargeMoneyController.close();
    await _confirmed.close();
    await _confirmController.close();
  }
}
