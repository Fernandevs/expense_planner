import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import 'package:expense_planner/data/models/transaction.dart';
import 'package:expense_planner/presentation/widgets/chart.dart';
import 'package:expense_planner/presentation/widgets/new_transaction.dart';
import 'package:expense_planner/presentation/widgets/transaction_list.dart';

class ExpensePlanner extends StatelessWidget {
  const ExpensePlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    setState(() {
      final transaction = Transaction(
        id: const Uuid().v4(),
        title: title,
        amount: amount,
        date: DateTime.now(),
      );

      _userTransactions.add(transaction);

      if (kDebugMode) {
        print(transaction);
      }
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(newTransactionHandler: _addNewTransaction),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Planner'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            TransactionList(transactions: _userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
