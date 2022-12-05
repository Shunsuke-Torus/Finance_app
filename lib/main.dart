import 'package:flutter/material.dart';
import 'widgets/user_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Finance App"),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    child: Text("Cfhart!"),
                  ),
                ),
              ),
              UserTransactions(),
              Card(
                color: Colors.red,
                child: Text("List Of Tx"),
              ),
            ],
          ),
        ));
  }
}
