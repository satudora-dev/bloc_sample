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
                stream: bloc.counter$,
                builder: (context, snapshot) => snapshot.hasData
                    ? Text('${snapshot.data}',
                        style: Theme.of(context).textTheme.display1)
                    : CircularProgressIndicator()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.increment.add(null),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
