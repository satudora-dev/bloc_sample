import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';
import './bloc_charge_view.dart';
import './bloc_charging_view.dart';

class BlocMerpayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MerpayModalBloc>(context);
    return Stack(
      children: [
        RaisedButton(
          child: Text('+'),
          onPressed: () {
            bloc.chargeBloc.visualize.add(true);
          },
        ),
        StreamBuilder(
          stream: bloc.chargeBloc.visible,
          initialData: false,
          builder: (context, snap) {
            if (snap.data) {
              return BlocConfirmView();
            } else {
              return Container();
            }
          },
        ),
        StreamBuilder(
          stream: bloc.chargingBloc.visible,
          initialData: false,
          builder: (context, snap) {
            if (snap.data) {
              return BlocChargingView();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
