import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Finance App",
      theme: ThemeData(
        fontFamily: "Quicksand",
        // errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: const TextStyle(
                fontFamily: "OpenSans",
                fontSize: 15,
                // color: Theme.of(context).primaryColor,
                color: Colors.grey,
              ),
              bodyLarge: const TextStyle(
                fontFamily: "OpenSans",
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: const TextStyle(
                fontFamily: "OpenSans",
                color: Colors.purple,
              ),
            ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //   ),
        // ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
            .copyWith(secondary: Colors.amber),
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

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 3999,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Bread",
    //   amount: 299,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t3",
    //   title: "New PC",
    //   amount: 150000,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: date,
    );
    //更新するsetState
    setState(() {
      _userTransactions.add(newTx);
      // スプレッド演算子で展開せずにポインタを受け継いだ状態で_userTransaction内に入れる｡
      // _userTransaction = [..._userTransaction, newTx];
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: _addNewTransaction),
        );
      },
    );
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: false,
      title: const Text(
        "Finance App",
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewtransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chart!"),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
            _showChart == true
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: TransactionList(
                      transactions: _userTransactions,
                      removeTransactions: _removeTransaction,
                    ),
                  ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewtransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
