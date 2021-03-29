import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen();

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Color baseColor = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClayContainer(
                color: baseColor,
                borderRadius: 16,
                depth: 30,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Text',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.link,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(16),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
