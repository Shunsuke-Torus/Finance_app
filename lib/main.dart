import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Finance App",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
              ),
              titleSmall: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 15,
                // color: Theme.of(context).primaryColor,
                color: Colors.grey,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: _MyHomePage(),
    );
  }
}

// accentColor:対応方法
// https://docs.flutter.dev/release/breaking-changes/theme-data-accent-properties
class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Bread",
      amount: 8.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "New PC",
      amount: 1499.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    //更新するsetState
    setState(() {
      _userTransaction.add(newTx);
      // スプレッド演算子で展開せずにポインタを受け継いだ状態で_userTransaction内に入れる｡
      // _userTransaction = [..._userTransaction, newTx];
    });
  }

  void _startAddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addTx: _addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Finance App",
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewtransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  child: Text("Chart!"),
                ),
              ),
            ),
            TransactionList(transactions: _userTransaction),
            Card(
              color: Colors.red,
              child: Text("List Of Tx"),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewtransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
