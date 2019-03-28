import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import './merpay_charge_bloc.dart';
import './merpay_charging_bloc.dart';

class MerpayModalBloc extends Bloc {
  MerpayChargeBloc _chargeBloc;
  MerpayChargingBloc _chargingBloc;

  final _completeProcedureController = PublishSubject<void>();

  MerpayModalBloc() {
    _chargeBloc = MerpayChargeBloc();
    _chargingBloc = MerpayChargingBloc();
    _chargeBloc.confirmed.listen((_val) {
      if (_val == true) {
        _chargingBloc.visualize.add(true);
      }
    });

    _completeProcedureController.listen((_) {
      _chargeBloc.visualize.add(false);
      _chargingBloc.visualize.add(false);
    });

    _chargingBloc.chargeCompleted.listen((_val) {
      if (_val == true) {
        _completeProcedureController.add(null);
      }
    });
  }

  MerpayChargeBloc get chargeBloc => _chargeBloc;
  MerpayChargingBloc get chargingBloc => _chargingBloc;

  @override
  void dispose() async {
    _chargeBloc.dispose();
    _chargingBloc.dispose();
  }
}

enum MerpayState {
  Waiting,
  Confirm,
  Charging,
  Complete,
}
