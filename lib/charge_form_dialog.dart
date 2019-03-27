import 'package:flutter/material.dart';
import 'package:bloc_sample/charge_bloc_provider.dart';
import 'package:bloc_sample/charge_bloc.dart';

class ChargeFormDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: bloc.chargedMoney$,
        builder: (context, snapshot) {
          if (snapshot.data == 33) {
            Navigator.pop(context);
            return MyCustomForm();
          } else {
            return MyCustomForm();
          }
        });
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  int _chargeMoney = 0;

  submit(bloc) {
    _formKey.currentState.save();
    bloc.addMoney.add(_chargeMoney);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    final bloc = BlocProvider.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
            onSaved: (String value) => this._chargeMoney = int.parse(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                this.submit(bloc);
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
