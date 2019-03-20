import 'package:flutter/material.dart';
import 'package:bloc_sample/charge_bloc_provider.dart';
import 'package:bloc_sample/charge_bloc.dart';

void main() {
  final bloc = ChargeBloc();
  runApp(MyApp(bloc));
}

class MyApp extends StatelessWidget {
  final ChargeBloc bloc;

  MyApp(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: bloc,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: bloc.chargedMoney$,
                builder: (context, snapshot) => snapshot.hasData
                    ? Text('${snapshot.data}',
                        style: Theme.of(context).textTheme.display1)
                    : CircularProgressIndicator()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(context, bloc),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  showModal(context, bloc){
    showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new MyCustomForm()
        ],
      );
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

  submit(bloc){
    _formKey.currentState.save();
    bloc.charge(_chargeMoney);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    // Build a Form widget using the _formKey we created above
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
