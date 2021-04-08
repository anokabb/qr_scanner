import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/components/CuperIcon.dart';
import 'package:qr_scanner/components/CustomAppBar.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen();

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        shape: CustomAppBar(),
        title: Text(
          'Result',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClayContainer(
                color: Theme.of(context).canvasColor,
                borderRadius: 16,
                spread: 10,
                depth: 10,
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
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                CuperIcon(
                  icon: Icons.share_rounded,
                  text: 'Share',
                  onPressed: () {},
                ),
                CuperIcon(
                  icon: Icons.copy_rounded,
                  text: 'Copy',
                  onPressed: () {},
                ),
                CuperIcon(
                  icon: Icons.web,
                  text: 'Search',
                  onPressed: () {},
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                ),
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
                Column(
                  children: <Widget>[
                    CuperIcon(
                        icon: Icons.share_rounded,
                        text: 'Share',
                        onPressed: () {}),
                    CuperIcon(
                        icon: Icons.save_alt_rounded,
                        text: 'Save',
                        onPressed: () {}),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
