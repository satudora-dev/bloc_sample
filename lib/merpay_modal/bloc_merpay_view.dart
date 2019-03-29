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
      children: <Widget>[
        Container(),
        RaisedButton(
          child: Text('+'),
          onPressed: () {
            bloc.chargeViewVisualize.add(true);
          },
        ),
        StreamBuilder(
          stream: bloc.chargeViewVisible,
          initialData: false,
          builder: (context, snap) {
            if (snap.data) {
              return Positioned.fill(
                child: Container(
                  color: Color.fromARGB(100, 0, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: BlocChargeView(),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        StreamBuilder(
          stream: bloc.chargingViewVisible,
          initialData: false,
          builder: (context, snap) {
            if (snap.data) {
              //return BlocChargingView();
              return Positioned.fill(
                child: Container(
                  color: Color.fromARGB(100, 0, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: BlocChargingView(),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
