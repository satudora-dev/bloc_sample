import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';

class BlocChargingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MerpayModalBloc bloc = BlocProvider.of<MerpayModalBloc>(context);

    return StreamBuilder(
        stream: bloc.chargingViewVisible,
        initialData: false,
        builder: (context, snap) {
          return Positioned.fill(
            child: IgnorePointer(
              ignoring: !snap.data,
              child: AnimatedOpacity(
                duration: Duration(
                  milliseconds: 500,
                ),
                opacity: snap.data ? 1 : 0,
                child: Container(
                  color: Color.fromARGB(100, 0, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Container(
                      color: Colors.amber[100],
                      child: Column(
                        children: <Widget>[
                          Text('チャージしています'),
                          RaisedButton(
                            child: Text('Done'),
                            onPressed: () {
                              //bloc.completeCharge.add(null);
                              bloc.completeAnimation.add(null);
                            },
                          ),
                          RaisedButton(
                            child: Text('Change Color'),
                            onPressed: () {
                              bloc.chargingBloc.changeColor
                                  .add(Color.fromARGB(100, 0, 0, 0));
                            },
                          ),
                          StreamBuilder(
                            stream: bloc.chargingBloc.color,
                            builder: (context, snap) => AnimatedContainer(
                                  padding: EdgeInsets.all(50),
                                  duration: Duration(
                                    milliseconds: 1000,
                                  ),
                                  color: snap.data,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
