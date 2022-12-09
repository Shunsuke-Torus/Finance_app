import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({required this.addTx});
  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // グローバルcontextプロパティより
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) => amountInput = value,
            ),
            // 日付
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Date: ${DateFormat.yMd().format(_selectedDate)}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _presentDatePicker,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      "Choose Date",
                      style: Theme.of(context).textTheme.bodyLarge,
                      // style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                "Add Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
