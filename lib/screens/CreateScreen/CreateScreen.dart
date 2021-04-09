import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../db/database_provider.dart';
import '../../models/QR.dart';
import '../../components/CustomAppBar.dart';
import '../../components/txtField.dart';
import '../ResultScreen/ResultScreen.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen();

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  ValueNotifier<String> text = ValueNotifier('');

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        shape: CustomAppBar(),
        title: Text(
          'Create QR',
        ),
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
              child: ValueListenableBuilder<String>(
                valueListenable: text,
                builder: (_, value, __) => QrImage(
                  data: value,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
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
                    controler: _controller,
                    hint: 'Type Text ...',
                    autofocus: false,
                    lines: 3,
                    onChanged: (s) => text.value = s,
                  ),
                ),
              ),
              CupertinoButton(
                child: Icon(
                  Icons.done_outline_rounded,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: createQR,
              )
            ],
          ),
        ],
      ),
    );
  }

  void createQR() {
    if (_controller.text.isNotEmpty) {
      QR Qr = QR(value: _controller.text, type: QR.TEXT, isScanned: false);
      DatabaseProvider.db.insert(context, Qr);
      pushNewScreen(
        context,
        screen: ResultScreen(Qr),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
    }
  }
}
