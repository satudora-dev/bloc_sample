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
  Color _chargeViewColor;
  Color _chargingViewColor;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    _chargeViewColor = Color.fromARGB(0, 0, 0, 0);

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
              _chargeViewColor = Color.fromARGB(100, 0, 0, 0);
            /*setState(() {
              print(_chargeViewColor);
              _chargeViewColor = Color.fromARGB(100, 0, 0, 0);
              print(_chargeViewColor);
            });*/
          },
        ),
        StreamBuilder(
          stream: bloc.chargeViewVisible,
          initialData: false,
          builder: (context, snap) {
            if (snap.data) {
              return Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  color: _chargeViewColor,
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
                    padding: EdgeInsets.all(100.0),
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
