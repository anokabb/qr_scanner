import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/QR.dart';
import '../components/CuperIcon.dart';
import '../components/CustomAppBar.dart';

class ResultScreen extends StatefulWidget {
  final QR Qr;
  ResultScreen(this.Qr);

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
        leading: CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: Text(
          'Result',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                            widget.Qr.typeToString(),
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
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: SelectableText(
                          widget.Qr.value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
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
                    child: QrImage(
                      data: widget.Qr.value,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                    // Container(
                    //   color: Colors.black26,
                    //   height: 200,
                    //   width: 200,
                    // ),
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
