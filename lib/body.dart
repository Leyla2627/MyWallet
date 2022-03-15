import 'package:flutter/material.dart';
import 'package:my_wallet/budget.dart';
import 'package:my_wallet/expense_list.dart';
import 'package:my_wallet/models/expense.dart';

class Body extends StatelessWidget {
  final List<Expense> expenses;
  final totalExpense;
  final Function deleteExpense;

  Body(this.expenses, this.totalExpense, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [Budget(totalExpense), Expenselist(expenses, deleteExpense)],
      ),
    );
  }
}
