import 'package:flutter/material.dart';
import 'package:my_wallet/edit_monthly_budget.dart';
import 'package:my_wallet/progress_bar.dart';

class Budget extends StatefulWidget {
  final totalExpense;

  Budget(this.totalExpense);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double _budgetLimit = 2000000.0;

  void editBudgetLimit(double value) {
    setState(() {
      _budgetLimit = value;
    });
  }

  void showMonthlyBudgetWindow(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return EditMonthlyBudget(editBudgetLimit, _budgetLimit);
        });
  }

  @override
  Widget build(BuildContext context) {
    final totalLimitPencentage = 100 * widget.totalExpense / _budgetLimit;

    return LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
              color: Color.fromRGBO(239, 240, 250, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("oylik budget: "),
                      TextButton.icon(
                          onPressed: () {
                            showMonthlyBudgetWindow(context);
                          },
                          icon: Icon(Icons.edit, size: 18),
                          label: Text("${_budgetLimit.toStringAsFixed(0)} so`m")),
                    ],
                  ),
                  Text(
                      "${totalLimitPencentage > 100 ? 100 : totalLimitPencentage.toStringAsFixed(2)}%")
                ],
              ),
              ProgressBar(totalLimitPencentage),
            ],
          ),
        );
      }
    );
  }
}
