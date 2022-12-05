import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactions createState() => _UserTransactions();
}

class _UserTransactions extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addTx: _addNewTransaction,
        ),
        TransactionList(transactions: _userTransaction),
      ],
    );
  }
}
