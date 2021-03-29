import 'package:clay_containers/clay_containers.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Create QR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          ClayContainer(
            color: Theme.of(context).canvasColor,
            borderRadius: 16,
            spread: 10,
            depth: 10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.black26,
                height: 200,
                width: 200,
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
