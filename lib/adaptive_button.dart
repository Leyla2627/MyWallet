import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function() handler;
  final bool? filled;

  const AdaptiveButton({Key? key, this.filled = false  , required this.text, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    filled! ?
    ElevatedButton(
        onPressed : handler,
        child: Text(text)) : TextButton(onPressed: handler, child: Text(text)) :
    filled! ? CupertinoButton.filled(
      child: Text(text),
      onPressed: handler,
    ) : CupertinoButton(
      child: Text(text),
      onPressed: handler,
    ) ;
  }
}
