import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/adaptive_button.dart';

import 'dart:io' show Platform;

import 'package:my_wallet/adaptive_textfield.dart';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;

  AddExpense(this.addNewExpense);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  IconData? _icon;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void showNewExpenseCalendar(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) => {
              if (date != null)
                setState(() {
                  _selectedDate = date;
                })
            });
  }

  void showExpenseIconPicker()  {
    FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]).then((value) =>{
   setState(() {
     if(value!=null){_icon = value;}
   })
    });
  }

  void _submit(){
    if (_titleController.text == null ||
        _amountController.text == null ||
        _selectedDate == null) return;
    var title = _titleController.text;
    var amount = double.parse(_amountController.text);
    if (amount <= 0) return;
    widget.addNewExpense(title, amount, _selectedDate, _icon);
   }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 16.0, bottom: MediaQuery.of(context).viewInsets.bottom >0 ? MediaQuery.of(context).viewInsets.bottom +16.0 : 100, left: 16.0, right: 16.0),
        child: Column(
          children: [
            AdaptiveTextField(controller: _titleController, label: "Xarajat nomi"),
            AdaptiveTextField(keyboardType: TextInputType.number, controller: _amountController, label: "Xarajat miqdori"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? "Xarajat kuni tanlanmadi!"
                    : "Xarajat kuni: ${DateFormat("dd, MMMM, y").format(_selectedDate!)}"),
                TextButton(
                  onPressed: () {
                    showNewExpenseCalendar(context);
                  },
                  child: Text("KUNNI TANLASH"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _icon == null ? Text("Rasm tanlang") : Row(
                  children: [
                    Text("Tanlangan rasm:"),
                    Icon(_icon, color: Colors.purple,),
                  ],
                ),
                TextButton(
                  onPressed: () {showExpenseIconPicker();},
                  child: Text("ICON TANLASH"),
                )
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdaptiveButton(text: 'BEKOR QILISH', handler: (){
                  Navigator.of(context).pop();
                }),
                AdaptiveButton(text: 'KIRITISH', handler: _submit, filled: true,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
