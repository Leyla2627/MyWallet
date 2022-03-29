import 'package:flutter/material.dart';
import 'package:my_wallet/adaptive_button.dart';

class EditMonthlyBudget extends StatefulWidget {
  final Function editBudget;
  final double budgetLimit;

  EditMonthlyBudget(this.editBudget, this.budgetLimit);

  @override
  State<EditMonthlyBudget> createState() => _EditMonthlyBudgetState();
}

class _EditMonthlyBudgetState extends State<EditMonthlyBudget> {
  late TextEditingController _monthlyBudgetController;

  @override
  void initState() {
    _monthlyBudgetController = TextEditingController();
    _monthlyBudgetController.text = widget.budgetLimit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    _monthlyBudgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Oylik budget miqdori"),
            keyboardType: TextInputType.number,
            controller: _monthlyBudgetController,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdaptiveButton(
                  handler: () {
                    Navigator.of(context).pop();
                  },
                  text: "BEKOR QILISH"),
              AdaptiveButton(text: 'O`ZGARTIRISH',
                  filled: true,
                  handler: (){
                if (_monthlyBudgetController.text == null) return;
                var value = double.parse(_monthlyBudgetController.text);
                if (value > 0) {
                  widget.editBudget(value);
                  Navigator.of(context).pop();
                }
              })
            ],
          )
        ],
      ),
    );
  }
}
