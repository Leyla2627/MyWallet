import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    this.icon = Icons.ac_unit,
  });
}

class Expenses {
  List<Expense> _items = [
    Expense(id: "e1", title: "Tarvuz", date: DateTime.now(), amount: 20000),
    Expense(
        id: "e2",
        title: "Krasofka",
        date: DateTime(2022, 2, 25),
        amount: 180000),
    Expense(
        id: "e3", title: "tufli", date: DateTime(2022, 2, 25), amount: 210000),
    Expense(
        id: "e4",
        title: "ice-cream",
        date: DateTime(2022, 2, 25),
        amount: 11000),
    Expense(id: "e5", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e6", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e7", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e8", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e9", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e10", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e11", title: "tufli", date: DateTime.now(), amount: 210000),
    Expense(id: "e12", title: "tufli", date: DateTime.now(), amount: 210000),
  ];

  List<Expense> get items {
    return _items;
  }

  List<Expense> itemByMonth(DateTime date) {
    return _items
        .where((element) =>
            date.month == element.date.month && date.year == element.date.year)
        .toList();
  }

  void addNewExpense(String title, double amount, DateTime date, IconData icon) {
    _items.add(Expense(
        id: "e${_items.length + 1}", title: title, date: date, amount: amount, icon: icon));
  }

  double totalExpenseByMonth(DateTime dateTime) {
    final expensesByMonth = itemByMonth(dateTime);

    return expensesByMonth.fold(0, (previousValue, expense) {
      return previousValue + expense.amount;
    });
  }

  void delete(String id){
    _items.removeWhere((element) => element.id == id);
  }
}
