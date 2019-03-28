import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';

class BlocChargingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MerpayModalBloc>(context).chargingBloc;
    return Container(
      color: Colors.amber[100],
      child: Column(
        children: <Widget>[
          Text('チャージしています'),
          RaisedButton(
            child: Text('Done'),
            onPressed: () {
              bloc.completeCharge.add(null);
            },
          )
        ],
      ),
    );
  }
}
