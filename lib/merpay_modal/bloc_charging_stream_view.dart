import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'dart:async';

import './merpay_modal_bloc.dart';
import './merpay_modal_animation_bloc.dart';

class BlocChargingStreamView extends StatefulWidget {
  @override
  BlocChargingStreamViewState createState() => BlocChargingStreamViewState();
}

class BlocChargingStreamViewState extends State<BlocChargingStreamView>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  Animation<double> fadeAnimation;

  StreamSubscription _streamSubscription;

  MerpayModalAnimationBloc _animationBloc;

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

    _animationBloc = BlocProvider.of<MerpayModalAnimationBloc>(context);
    _streamSubscription = _animationBloc.animationCompleted.listen((value) {
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
    final bloc = BlocProvider.of<MerpayModalBloc>(context);
    return StreamBuilder(
        stream: bloc.chargingViewVisible,
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
                                _animationBloc.completeAnimation.add(null);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}
