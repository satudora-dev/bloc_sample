import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';
import './bloc_charge_view.dart';
import './bloc_charging_view.dart';

class BlocMerpayView extends StatelessWidget{

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
            return Positioned.fill(
              child: IgnorePointer(
                ignoring: !snap.data,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: snap.data ? 1 : 0,
                  child: Container(
                    color: Color.fromARGB(100, 0, 0, 0),
                    child:Padding(
                    padding: EdgeInsets.all(50),
                    child: BlocChargeView(),
                  ),
                ),
                ),
              ),
            );
          },
        ),
        BlocChargingView(),
      ],
    );
  }
}
