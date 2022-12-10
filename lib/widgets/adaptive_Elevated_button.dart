import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdapativeElevatedButton extends StatelessWidget {
  final String text;
  var handler;
  AdapativeElevatedButton({required this.text, this.handler});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onPressed: handler)
        : ElevatedButton(
            onPressed: handler,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(color: Colors.amber),
            ),
          );
  }
}
