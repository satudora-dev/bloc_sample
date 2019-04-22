import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class MerpayChargingBloc extends Bloc {
  
  final _chargeCompleted = BehaviorSubject<bool>.seeded(false);
  final _completeChargeController = PublishSubject<void>();

  final _color = BehaviorSubject<Color>.seeded(Color.fromARGB(255, 0, 0, 0));
  final _changeColorController = PublishSubject<Color>();

  MerpayChargingBloc() {
    _completeChargeController.listen((_) => _chargeCompleted.add(true));

    _changeColorController.listen((color) => _color.add(color));
  }

  ValueObservable<bool> get chargeCompleted => _chargeCompleted;
  Sink<void> get completeCharge => _completeChargeController;

  ValueObservable<Color> get color => _color;
  Sink<void> get changeColor => _changeColorController;

  @override
  void dispose() async {
    await _chargeCompleted.close();
    await _completeChargeController.close();

    await _color.close();
    await _changeColorController.close();
  }
}
