import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import './merpay_charge_bloc.dart';
import './merpay_charging_bloc.dart';

class MerpayModalBloc extends Bloc {
  MerpayChargeBloc _chargeBloc;
  MerpayChargingBloc _chargingBloc;

  final _chargeViewVisible = BehaviorSubject<bool>.seeded(false);
  final _chargeViewVisualizeController = PublishSubject<bool>();

  final _chargingViewVisible = BehaviorSubject<bool>.seeded(false);
  final _chargingViewVisualizeController = PublishSubject<bool>();

  final _animationCompleted = BehaviorSubject<bool>.seeded(false);
  final _completeAnimationController = PublishSubject<void>();

  final _completeProcedureController = PublishSubject<void>();

  MerpayModalBloc() {
    _chargeBloc = MerpayChargeBloc();
    _chargingBloc = MerpayChargingBloc();

    _chargeViewVisualizeController
        .listen((_val) => _chargeViewVisible.add(_val));

    _chargingViewVisualizeController
        .listen((_val) => _chargingViewVisible.add(_val));

    _chargeBloc.confirmed.listen((_val) {
      if (_val == true) {
        chargingViewVisualize.add(true);
      }
    });

    _chargingBloc.chargeCompleted.listen((_val) {
      if (_val == true) {
        _completeProcedureController.add(null);
      }
    });

    _completeAnimationController.listen((_) {
      _animationCompleted.add(true);
      _completeProcedureController.add(null);
    });

    _completeProcedureController.listen((_) {
      chargeViewVisualize.add(false);
      chargingViewVisualize.add(false);
    });
  }

  MerpayChargeBloc get chargeBloc => _chargeBloc;
  MerpayChargingBloc get chargingBloc => _chargingBloc;

  ValueObservable<bool> get chargeViewVisible => _chargeViewVisible;
  Sink<bool> get chargeViewVisualize => _chargeViewVisualizeController;

  ValueObservable<bool> get chargingViewVisible => _chargingViewVisible;
  Sink<bool> get chargingViewVisualize => _chargingViewVisualizeController;

  ValueObservable<bool> get animationCompleted => _animationCompleted;
  Sink<void> get completeAnimation => _completeAnimationController;

  @override
  void dispose() async {
    _chargeBloc.dispose();
    _chargingBloc.dispose();

    await _chargeViewVisible.close();
    await _chargeViewVisualizeController.close();

    await _chargingViewVisible.close();
    await _chargingViewVisualizeController.close();

    await _animationCompleted.close();
    await _completeAnimationController.close();

    await _completeProcedureController.close();
  }
}

enum MerpayState {
  Waiting,
  Confirm,
  Charging,
  Complete,
}
