import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.removeTransactions,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransactions;

  @override
  Widget build(BuildContext context) {
    return Card(
      // 全てのカードに5の高さを追加
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  "¥${NumberFormat("#,###", "ja_JP").format(transaction.amount)}"),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        // trailingウィジェットによってListTileの末尾に要素を追加しゴミ箱アイコン・ボタンを配置可能
        trailing: MediaQuery.of(context).size.width > 460
            ? ElevatedButton.icon(
                onPressed: () => removeTransactions(transaction.id),
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).errorColor),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeTransactions(transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
