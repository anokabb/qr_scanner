import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuperIcon extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String? text;
  const CuperIcon({
    required this.onPressed,
    required this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
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
