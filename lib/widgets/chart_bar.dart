import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar({
    super.key,
    required this.label,
    required this.spendingAmount,
    required this.spendingPctOfTotal,
  });

  // 背景色が必要な理由
  // 棒グラフの何%かにだけ背景色を付けることからどのように棒グラフの内部にて背景色を付けるべきか知るため

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            // FittedBoxによって行の折り返しを追加することを防ぐ
            // スペースが不足したら文字が縮小するようにする
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "¥${spendingAmount.toStringAsFixed(0)}",
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
              // height: 5,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  // 重なり合うように配置する
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      // color: const Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      // 角を丸くするため 境界線の半径が必要
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // 1/nかの大きさのボックスを作成
                  FractionallySizedBox(
                    // 高さ 0 ~ 1の間　1=100%を指す 親のContainerのサイズを見すことから､最大でもheight:60
                    heightFactor: 1 - spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        //color: Theme.of(context).primaryColor,
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        // 2つのコンテナを重ねて配置することで､borderとedgeを一致させる
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
