import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:bloc_sample/charge_api_mock.dart';

class ChargeBloc {
  int _chargedMoney = 0;

  final _chargedMoney$ = BehaviorSubject<int>.seeded(0);
  final _incrementController = StreamController<int>();

  ChargeBloc() {
    _incrementController.stream.listen((additionalMoney) => _charge(additionalMoney));
  }

  Sink<int> get addMoney => _incrementController.sink;

  Stream<int> get chargedMoney$ => _chargedMoney$.stream;


  void _charge(int money) async {
    int newChargedMoney = await ChargeAPIMock().post(money);
    _chargedMoney += newChargedMoney;
    _chargedMoney$.add(_chargedMoney);
  }

  void dispose() {
    _incrementController.close();
    _chargedMoney$.close();
  }
}
