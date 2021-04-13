import 'dart:io';
import 'dart:typed_data';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Utils/Localization/app_localizations.dart';
import '../components/QrIconType.dart';
import '../cubit/theme_cubit.dart';
import 'package:share/share.dart';
import '../models/QR.dart';
import '../components/CuperIcon.dart';
import '../components/CustomAppBar.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class ResultScreen extends StatefulWidget {
  final QR Qr;
  ResultScreen(this.Qr);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScreenshotController screenshotController = ScreenshotController();
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
          'QR',
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
                spread:
                    BlocProvider.of<ThemeCubit>(context).state.isDark ? 0 : 10,
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
                              color: Theme.of(context).splashColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            getIconType(widget.Qr.type!),
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
                            color: Theme.of(context).splashColor,
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
                  text: translate(context, 'share'),
                  onPressed: () {
                    Share.share(widget.Qr.value);
                  },
                ),
                CuperIcon(
                  icon: Icons.copy_rounded,
                  text: translate(context, 'copy'),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: widget.Qr.value));
                    Fluttertoast.showToast(
                        msg: translate(context, 'copied_clipboard'));
                  },
                ),
                CuperIcon(
                  icon: Icons.web,
                  text: translate(context, 'search'),
                  onPressed: () async {
                    await FlutterWebBrowser.openWebPage(
                        url: "https://www.google.com/search?q=" +
                            widget.Qr.value,
                        customTabsOptions: CustomTabsOptions(
                            toolbarColor: Theme.of(context).primaryColor));
                  },
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
                  color: BlocProvider.of<ThemeCubit>(context).state.isDark
                      ? Colors.white
                      : Theme.of(context).canvasColor,
                  borderRadius: 16,
                  spread: BlocProvider.of<ThemeCubit>(context).state.isDark
                      ? 0
                      : 10,
                  depth: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Screenshot(
                      controller: screenshotController,
                      child: QrImage(
                        data: widget.Qr.value,
                        version: QrVersions.auto,
                        size: 200,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    CuperIcon(
                        icon: Icons.share_rounded,
                        text: translate(context, 'share'),
                        onPressed: () {
                          screenshotController
                              .capture()
                              .then((Uint8List? image) async {
                            Directory directory =
                                await getApplicationDocumentsDirectory();
                            File file = await File(directory.path + '/qr.png')
                                .writeAsBytes(image!);
                            Share.shareFiles([file.path]);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }),
                    CuperIcon(
                        icon: Icons.save_alt_rounded,
                        text: translate(context, 'save'),
                        onPressed: () {
                          screenshotController
                              .capture()
                              .then((Uint8List? image) async {
                            final params = SaveFileDialogParams(
                              data: image,
                              fileName: '${DateTime.now().toString()}.jpg',
                            );
                            final filePath = await FlutterFileDialog.saveFile(
                                params: params);
                            print(filePath);
                          }).catchError((onError) {
                            print(onError);
                          });
                        }),
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
