import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Key key;
  final Function deleteExpense;
  final IconData icon;

  ExpenseItem(this.id, this.title, this.date, this.amount, this.key,
      this.deleteExpense, this.icon)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        deleteExpense(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.purple,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat("dd MMMM, y").format(date)),
        trailing: Text(
          "$amount so`m",
          style: TextStyle(color: Colors.purple),
        ),
      ),
    );
  }
}
