import 'package:flutter/material.dart';
import '../Repository/HealthProfileRepository.dart';
import '../Model/HealthProfile.dart';

class CalendarInputForm extends StatefulWidget {
  DateTime date;

  CalendarInputForm(this.date);

  @override
  _CalendarInputFormState createState() => _CalendarInputFormState(date);
}

class _CalendarInputFormState extends State<CalendarInputForm> {
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  TextEditingController weightInputController;
  TextEditingController bodyTemperatureInputController;

  DateTime date;

  _CalendarInputFormState(this.date);

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  void getInitialData() async {
    final healthProfileRepository = HealthProfileRepository();
    final healthProfile = await healthProfileRepository.getByDate(date);
    if (healthProfile == null) {
      weightInputController = new TextEditingController(text: "");
      bodyTemperatureInputController = new TextEditingController(text: "");
    } else {
      weightInputController =
          new TextEditingController(text: healthProfile.weight);
      bodyTemperatureInputController =
          new TextEditingController(text: healthProfile.bodyTemperature);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                  child: TextFormField(
                decoration: InputDecoration(
                  labelText: '体重',
                ),
                autofocus: true,
                controller: weightInputController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                  child: TextFormField(
                decoration: InputDecoration(
                  labelText: '基礎体温',
                ),
                controller: bodyTemperatureInputController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
              ))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
                child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  //Scaffold.of(context)
                  //    .showSnackBar(SnackBar(content: Text('Processing Data')));
                  this.submit();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Submit'),
            )),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    weightInputController.dispose();
    bodyTemperatureInputController.dispose();
    super.dispose();
  }

  void submit() {
    final healthProfile = HealthProfile(
        date, weightInputController.text, bodyTemperatureInputController.text);
    final healthProfileRepository = HealthProfileRepository();
    healthProfileRepository.save(healthProfile);
    healthProfileRepository.getAllHealthProfile();
  }
}
