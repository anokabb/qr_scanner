import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuperIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final bool isBrowser;
  final String? text;
  const CuperIcon({
    required this.onPressed,
    required this.icon,
    this.text,
    this.isBrowser = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Column(
        children: [
          isBrowser
              ? Image.asset(
                  'images/browser.png',
                  width: 30,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
          text == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    text!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
