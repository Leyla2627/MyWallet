import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool _showExpenseList = false;

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
      isScrollControlled: true,
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

  void deleteExpense(String id) {
    setState(() {
      expenseData.delete(id);
    });
  }

  Widget _showPortraitItems(totalByMonth, deviceHeight, deviceWidth){
    return Column(children: [
      Container(
        width: deviceWidth,
        height: deviceHeight > 640 ? deviceHeight * 0.2 : deviceHeight * 0.3,
        child: Header(showCalendar, _markedDate, previousMonth, nextMonth,
          totalByMonth),
      ),
      Container(
        width: deviceWidth,
        height: deviceHeight > 640 ? deviceHeight * 0.8 : deviceHeight * 0.7,
        child: Body(expenseData.itemByMonth(_markedDate), totalByMonth,
            deleteExpense),
      ),],);
  }

  Widget _showLandscapeItems(totalByMonth, deviceHeight, deviceWidth){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
       Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Ro`yxatni ko`rsatish"),
         Switch.adaptive(value: _showExpenseList, onChanged: (value){
          setState(() {
            _showExpenseList = value;
          });
        })],
       ),
       _showExpenseList ? Container(
         width: deviceWidth,
         height: deviceHeight * 0.9,
         child: Body(expenseData.itemByMonth(_markedDate), totalByMonth,
             deleteExpense),
       ) : Container(
         width: deviceWidth,
         height: deviceHeight * 0.9,
         child: Header(showCalendar, _markedDate, previousMonth, nextMonth,
    totalByMonth),
       ),
     ],
   );
  }



  @override
  Widget build(BuildContext context) {
    final totalByMonth = expenseData.totalExpenseByMonth(_markedDate);
    final isLandscape = MediaQuery.of(context).orientation ==Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: const Text("My Wallet"),
      actions: Platform.isIOS ? [
        IconButton(onPressed: (){}, icon: Icon(Icons.add))
      ] : []
    );

    final deviceHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body:SingleChildScrollView(
        child: Column(
          children: [
            isLandscape ? _showLandscapeItems(totalByMonth, deviceHeight, deviceWidth) : _showPortraitItems(totalByMonth, deviceHeight, deviceWidth),
            ],
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
