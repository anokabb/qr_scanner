import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/components/txtField.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen();

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create QR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.red,
                height: 200,
                width: 200,
              ),
            ),
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: TxtField(
                    context,
                    hint: 'Type Text ...',
                  ),
                ),
              ),
              CupertinoButton(
                child: Icon(
                  Icons.done_outline_rounded,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
