import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import './adaptive_Elevated_button.dart';

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // viewに追加して現れるもの(キーボード情報を得られる)
            // Error コンテンツの重なり合いでエラーが生じトラカラーが表示される
            // コンテンツが重ならないようにSingleChildScrollViewにてスクロールできるようにして回避する
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
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
                    AdapativeElevatedButton(
                      text: "ChooseDate",
                      handler: _presentDatePicker,
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
      ),
    );
  }
}
