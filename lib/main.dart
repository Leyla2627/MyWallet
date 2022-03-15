import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_wallet/add_expense.dart';
import 'package:my_wallet/body.dart';
import 'package:my_wallet/header.dart';

import 'models/expense.dart';

void main() {
// landscape ni o`chirish
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      title: "My Wallet",
      home: MyWallet(),
    );
  }
}

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  Expenses expenseData = Expenses();
  DateTime _markedDate = DateTime.now();

  void showCalendar(BuildContext context) {
    showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((month) {
      if (month != null) {
        setState(() {
          _markedDate = month;
        });
      }
    });
  }

  void previousMonth() {
    setState(() {
      if (_markedDate.year == 2021 && _markedDate.month == 1) {
        return;
      }
      _markedDate =
          DateTime(_markedDate.year, _markedDate.month - 1, _markedDate.day);
    });
  }

  void nextMonth() {
    if (_markedDate.year == DateTime.now().year &&
        _markedDate.month == DateTime.now().month) {
      return;
    }
    setState(() {
      _markedDate =
          DateTime(_markedDate.year, _markedDate.month + 1, _markedDate.day);
    });
  }

  void showAddExpenseWindow(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (ctx) {
          return AddExpense(addNewExpense);
        });
  }

  void addNewExpense(String title, double amount, DateTime date, IconData icon) {
    setState(() {
      expenseData.addNewExpense(title, amount, date, icon);
      Navigator.of(context).pop();
    });
  }

  void deleteExpense(String id){
   setState(() {
     expenseData.delete(id);
   });
  }

  @override
  Widget build(BuildContext context) {
    final totalByMonth = expenseData.totalExpenseByMonth(_markedDate);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Wallet"),
      ),
      body:
      Expanded(
        flex: 1,
        child: ListView(
            children:[Column(children: [Header(showCalendar, _markedDate, previousMonth, nextMonth, totalByMonth),
              Body(expenseData.itemByMonth(_markedDate), totalByMonth, deleteExpense),
            ],
            ),]

          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddExpenseWindow(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
