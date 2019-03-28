import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';

class BlocConfirmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MerpayModalBloc>(context).chargeBloc;
    return Container(
      color: Colors.amber[50],
      child: Column(
        children: <Widget>[
          Text('Modal A'),
          Text('10,000\$'),
          RaisedButton(
            child: Text('チャージする'),
            onPressed: () {
              bloc.confirm.add(null);
            },
          ),
        ],
      ),
    );
  }
}
