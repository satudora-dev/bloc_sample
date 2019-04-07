import 'package:flutter/material.dart';
import 'package:bloc_provider/bloc_provider.dart';

import './merpay_modal_bloc.dart';
import './bloc_charge_view.dart';
import './bloc_charging_view.dart';


class BlocMerpayView extends StatefulWidget {
  @override
  BlocMerpayViewState createState() => BlocMerpayViewState();
}

class BlocMerpayViewState extends State<BlocMerpayView>
    with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

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
            controller.forward();
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
                  child: FadeTransition(
                    opacity: animation,
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: BlocChargeView(),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        BlocChargingView()
      ],
    );
  }
}
