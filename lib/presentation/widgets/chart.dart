import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:expense_planner/data/models/transaction.dart';
import 'package:expense_planner/presentation/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTransactions =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        var amount = 0.0;

        for (Transaction transaction in recentTransactions) {
          if (transaction.date.day == weekDay.day &&
              transaction.date.month == weekDay.month &&
              transaction.date.year == weekDay.year) {
            amount += transaction.amount;
          }
        }

        return {'day': DateFormat.E().format(weekDay)[0], 'amount': amount};
      }).reversed.toList();

  double get total => groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: transaction['day'].toString(),
                      spendingAmount:
                          double.parse(transaction['amount'].toString()),
                      spendingPercentageOfTotal: total == 0.0
                          ? 0.0
                          : (transaction['amount'] as double) / total,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
