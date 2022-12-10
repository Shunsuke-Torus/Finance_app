import 'package:finance_app/models/transaction.dart';
import 'package:finance_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Chart extends StatelessWidget {
  var locale = initializeDateFormatting('ja');
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});
  // Chart({required this.recentTransactions}) {
  //   print("Constructor Chart");
  // }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }

        return {
          "day": DateFormat.E("ja").format(weekDay).substring(0, 1),
          "amount": totalSum,
        };
      },
      // 左側が最も古い記録:日付 右側が今日になる｡
    ).reversed.toList();
  }

  // 最終的に週の金額の合計
  double get totalSpending {
    // fold(第1引数:現在計算されている合計の指定 第2引数:私達が注目している要素)
    return groupedTransactionValues.fold(
      0.0,
      (sum, item) {
        return sum + (item["amount"] as double);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build() ChartBar");

    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Row(
          // 周囲のスペースを確保
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              // looseにするとスペース制限が加えられる = 文字が長いと余白も増大し視認性の悪化
              // tightにすると余白は変化なし 見やすい
              // tightの本質 余白(自分が取れるスペース)はすべて取る
              // flexの本質 Flexibleのウィジェットが複数ある場合に､それぞれのウィジェット同士の割合を指定したい際に利用される
              fit: FlexFit.tight,
              child: ChartBar(
                label: (data["day"] as String),
                spendingAmount: (data["amount"] as double),
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// flutter: [{day: Wed, amount: 134631.0}, {day: Tue, amount: 0.0}, {day: Mon, amount: 0.0}, {day: Sun, amount: 0.0}, {day: Sat, amount: 0.0}, {day: Fri, amount: 0.0}, {day: Thu, amount: 0.0}]
