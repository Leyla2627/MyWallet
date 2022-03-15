import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final Function showCalendar;
  final DateTime markedDate;
  final Function previousMonth;
  final Function nextMonth;
  final double totalExpense;

  Header(this.showCalendar, this.markedDate, this.previousMonth, this.nextMonth,
      this.totalExpense);

  @override
  Widget build(BuildContext context) {
    final lastTime = markedDate.year == DateTime.now().year &&
        markedDate.month == DateTime.now().month;
    final firstTime = markedDate.year == 2021 && markedDate.month == 1;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                showCalendar(context);
              },
              child: Text(
                DateFormat("MMMM, yyyy").format(markedDate),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      previousMonth();
                    },
                    icon: Icon(Icons.arrow_left)),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: firstTime ? Colors.grey : Colors.purple),
                    borderRadius: BorderRadius.circular(30)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${totalExpense.toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "So'm",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 0.8,
                    ),
                  )
                ],
              ),
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      nextMonth();
                    },
                    icon: Icon(Icons.arrow_right)),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: lastTime ? Colors.grey : Colors.purple),
                    borderRadius: BorderRadius.circular(30)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
