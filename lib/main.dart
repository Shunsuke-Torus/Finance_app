import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    // 一度取得し1つのオブジェクトに保存することでビルドウィジェット全体で再利用する
    // ビルドメソッド開始時に前もって取得することで新しい変数が早く効率よく作成される
    final mediaQuery = MediaQuery.of(context);

    // 縦横判定
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Finance App",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewtransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            centerTitle: false,
            title: Text(
              "Finance App",
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewtransaction(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ) as PreferredSizeWidget;
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        removeTransactions: _removeTransaction,
      ),
    );
    // print(appBar.preferredSize.height); flutter:44.0
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart!",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewtransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
