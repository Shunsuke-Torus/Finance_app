import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransactions;

  const TransactionList(
      {required this.transactions, required this.removeTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: ((ctx, constraints) {
                return Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.15,
                      child: Text(
                        "No transactions added yet!",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              }),
            )
          // ListViewは高さが無限にあるから親で指定する必要がある｡
          : ListView.builder(
              itemBuilder: ((context, index) {
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
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              "¥${NumberFormat("#,###", "ja_JP").format(transactions[index].amount)}"),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // trailingウィジェットによってListTileの末尾に要素を追加しゴミ箱アイコン・ボタンを配置可能
                    trailing: MediaQuery.of(context).size.width > 460
                        ? ElevatedButton.icon(
                            onPressed: () =>
                                removeTransactions(transactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).errorColor),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                removeTransactions(transactions[index].id),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              }),
              // itemBuilder: (ctx, index) {
              //   return Card(
              //     child: Row(
              //       children: [
              //         Container(
              //           margin: const EdgeInsets.symmetric(
              //             vertical: 10,
              //             horizontal: 15,
              //           ),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: Theme.of(context).primaryColorDark,
              //               width: 2,
              //             ),
              //           ),
              //           padding: const EdgeInsets.all(10),
              //           child: Text(
              //             //特殊文字の場合は､
              //             "¥ ${transactions[index].amount.toStringAsFixed(0)}",
              //             style: TextStyle(
              //                 //太字
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //                 color: Theme.of(context).primaryColor),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               transactions[index].title,
              //               style: Theme.of(context).textTheme.titleLarge,
              //               // style: TextStyle(
              //               //   fontSize: 16,
              //               //   fontWeight: FontWeight.bold,
              //               // ),
              //             ),
              //             Text(
              //               DateFormat.yMMMMd()
              //                   .format(transactions[index].date),
              //               style: Theme.of(context).textTheme.titleSmall,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   );
              // },
              // 構築すべきアイテム数
              itemCount: transactions.length,
            ),
    );
  }
}
