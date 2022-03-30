import 'package:flutter/material.dart';
import 'package:my_wallet/expense_item.dart';

import 'models/expense.dart';

class Expenselist extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;

  Expenselist(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height -100- MediaQuery.of(context).viewPadding.top - AppBar().preferredSize.height;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width,
        height: constraints.maxHeight - 104,
        margin: const EdgeInsets.only(top: 104),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: expenses.length > 0
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 10, right: 5),
                itemBuilder: (ctx, i) {
                  return ExpenseItem(
                      expenses[i].id,
                      expenses[i].title,
                      expenses[i].date,
                      expenses[i].amount,
                      ValueKey(expenses[i].id),
                      deleteExpense,
                      expenses[i].icon);
                },
                itemCount: expenses.length,
              )
            : Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Xarajatlar yo`q",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/ufo.png",
                  fit: BoxFit.cover,
                  width: 200,
                )
              ]),
      );
    });
  }
}
