import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'dart:async';

import './merpay_modal_bloc.dart';

class BlocChargingView extends StatefulWidget {
  @override
  BlocChargingViewState createState() => BlocChargingViewState();
}

class BlocChargingViewState extends State<BlocChargingView>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  StreamSubscription _streamSubscription;

  MerpayModalBloc _bloc;

  @override
  void initState() {
    super.initState();
    fadeController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );

    fadeController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        final bloc = BlocProvider.of<MerpayModalBloc>(context).chargingBloc;
        bloc.completeCharge.add(null);
      }
    });

    _bloc = BlocProvider.of<MerpayModalBloc>(context);
    _streamSubscription = _bloc.animationCompleted.listen((value) {
      startAnimation();
    });
  }

  startAnimation() {
    final status = fadeAnimation.status;
    debugPrint(status.toString());
    if (status == AnimationStatus.dismissed) {
      fadeController.forward();
    } else if (status == AnimationStatus.completed) {
      fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.chargingViewVisible,
        initialData: false,
        builder: (context, snap) {
          if (snap.data) {
            return Positioned.fill(
              child: Container(
                color: Color.fromARGB(100, 0, 0, 0),
                child: FadeTransition(
                  opacity: fadeAnimation,
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
                              _bloc.completeAnimation.add(null);
                            },
                          ),
                          RaisedButton(
                            child: Text('Change Color'),
                            onPressed: () {
                              _bloc.chargingBloc.changeColor
                                  .add(Color.fromARGB(100, 0, 0, 0));
                            },
                          ),
                          StreamBuilder(
                            stream: _bloc.chargingBloc.color,
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
            );
          } else {
            return Container();
          }
        });
  }
}
