import 'package:flutter/material.dart';

import './bloc_provider.dart';
import './counter_bloc.dart';

void main(){
  final bloc=CounterBloc();
  runApp(MyApp(bloc));
}

class MyApp extends StatelessWidget{
  final CounterBloc bloc;

  MyApp(this.bloc);

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      bloc: bloc,
      child: MaterialApp(
        title: 'BLoC Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo'),
      )
      );
  }
}

class MyHomePage extends StatelessWidget{
  MyHomePage({Key key,this.title}):super(key:key);
  final String title;

  @override
  Widget build(BuildContext context){
    final bloc=BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.counter$,
              builder: (context,snapshot){
                return snapshot.hasData
                ? Text(snapshot.data,
                style: Theme.of(context).textTheme.display1)
                : CircularProgressIndicator();                
              }
            ),
          ],
      )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: (){bloc.increment.add('Left');},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (){bloc.increment.add('Right');},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      )
    );
  }
}