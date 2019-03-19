import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:bloc_sample/charge_api_mock.dart';

class ChargeBloc {
  int _chargedMoney = 0;

  final _chargedMoney$ = BehaviorSubject<int>.seeded(0);
  final _incrementController = StreamController<void>();

  ChargeBloc() {
    _incrementController.stream.listen((void _) => _chargedMoney$.add(_chargedMoney));
  }

  Sink<void> get addMoney => _incrementController.sink;

  Stream<int> get chargedMoney$ => _chargedMoney$.stream;

  charge(int chargeMoney) async {
    int newChargedMoney = await ChargeAPIMock().post(chargeMoney);
    _chargedMoney += newChargedMoney;
    addMoney.add(_chargedMoney);
  }

  void dispose() {
    _incrementController.close();
    _chargedMoney$.close();
  }
}
