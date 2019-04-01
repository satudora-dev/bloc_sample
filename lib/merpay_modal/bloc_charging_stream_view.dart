import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';
import './bloc_charging_view.dart';
import 'dart:async';

import './merpay_modal_bloc.dart';
import './merpay_modal_animation_bloc.dart';

class BlocChargingStreamView extends StatefulWidget {
  @override
  BlocChargingStreamViewState createState() => BlocChargingStreamViewState();
}

class BlocChargingStreamViewState extends State<BlocChargingStreamView>
    with TickerProviderStateMixin {
  //Color _chargingViewColor;
  Color _chargeViewColor;

  AnimationController fadeController;
  Animation<double> fadeAnimation;

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
    _chargeViewColor = Color.fromARGB(0, 0, 0, 0);

    //
    fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //fadeController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //fadeController.forward();
        final bloc = BlocProvider.of<MerpayModalBloc>(context).chargingBloc;
        bloc.completeCharge.add(null);
      }
    });

    final bloc = BlocProvider.of<MerpayModalAnimationBloc>(context);
    if (bloc.animationCompleted != _previousStream) {
      _streamSubscription?.cancel();
      _previousStream = bloc.animationCompleted;
      _listen(bloc.animationCompleted);
    }
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

  StreamSubscription _streamSubscription;
  Stream _previousStream;

  void _listen(Stream<bool> stream) {
    _streamSubscription = stream.listen((value) {
      startAnimation();
    });
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
//return BlocChargingView();
            return Positioned.fill(
              child: Container(
                  color: Color.fromARGB(100, 0, 0, 0),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Padding(
                      padding: EdgeInsets.all(100.0),
                      child: BlocChargingView(),
                    ),
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}
