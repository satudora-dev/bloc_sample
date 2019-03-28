import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class MerpayChargeBloc extends Bloc {

  final _chargeAmount = BehaviorSubject<int>.seeded(0);
  final _chargeMoneyController = PublishSubject<int>();

  final _confirmed = BehaviorSubject<bool>.seeded(false);
  final _confirmController = PublishSubject<void>();

  MerpayChargeBloc() {
    _chargeMoneyController.listen((_amount) => _chargeAmount.add(_amount));

    _confirmController.listen((_) => _confirmed.add(true));
  }

  ValueObservable<int> get chargeAmount => _chargeAmount;
  Sink<int> get chargeMoney => _chargeMoneyController.sink;

  ValueObservable<bool> get confirmed => _confirmed;
  Sink<void> get confirm => _confirmController.sink;

  @override
  void dispose() async {
    await _chargeAmount.close();
    await _chargeMoneyController.close();
    
    await _confirmed.close();
    await _confirmController.close();
  }
}
