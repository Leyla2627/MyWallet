import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final totalLimitPercentage;

  ProgressBar(this.totalLimitPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 5,
        decoration: BoxDecoration(
            color: Color.fromRGBO(212, 219, 239, 1),
            borderRadius: BorderRadius.circular(5)),
        child: FractionallySizedBox(
            heightFactor: 2,
            widthFactor: totalLimitPercentage / 100.0,
            child: Container(
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.purple,
                    Colors.purple,
                    Colors.purple.shade200,
                    Colors.purple
                  ]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.purple, blurRadius: 10, spreadRadius: -3),
                  ],
                  borderRadius: BorderRadius.circular(10)),
            )));
  }
}
