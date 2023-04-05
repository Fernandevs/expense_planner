import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  const NewTransaction({Key? key, required this.newTransactionHandler})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTransaction();
}

class _NewTransaction extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.newTransactionHandler(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.text,
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder()
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              onSubmitted: (_) => submitData,
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),
              onPressed: submitData,
              child: const Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
