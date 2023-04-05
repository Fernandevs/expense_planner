import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:expense_planner/data/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMd().format(transactions[index].date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
