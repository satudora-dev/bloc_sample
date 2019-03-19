import 'package:flutter/material.dart';

import './bloc_provider.dart';
import './app_bloc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final AppBloc bloc;

  MyApp():bloc=AppBloc();

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
              stream: bloc.counterBloc.counter$,
              builder: (context,snapshot){
                return snapshot.hasData
                ? Text(snapshot.data,
                style: Theme.of(context).textTheme.display1)
                : CircularProgressIndicator();                
              }
            ),
            StreamBuilder(
              stream: bloc.reverseCounterBloc.counter$,
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
            onPressed: (){
              bloc.counterBloc.increment.add('Left');
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (){
              bloc.counterBloc.increment.add('Right');
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      )
    );
  }
}