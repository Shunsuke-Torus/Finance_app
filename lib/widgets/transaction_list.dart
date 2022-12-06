import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    //特殊文字の場合は､
                    "\$ ${transactions[index].amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        //太字
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        // 構築すべきアイテム数
        itemCount: transactions.length,
      ),
    );
  }
}
