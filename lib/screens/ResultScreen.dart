import 'dart:typed_data';
import 'package:clay_containers/clay_containers.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/components/MyBanner.dart';
import '../Utils/Localization/app_localizations.dart';
import '../components/QrIconType.dart';
import '../cubit/theme_cubit.dart';
import 'package:share_plus/share_plus.dart';
import '../models/QR.dart';
import '../components/CuperIcon.dart';
import '../components/CustomAppBar.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'MainScreen.dart';

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
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
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
                    spread: BlocProvider.of<ThemeCubit>(context).state.isDark
                        ? 0
                        : 10,
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
                        Clipboard.setData(
                            new ClipboardData(text: widget.Qr.value));
                        Fluttertoast.showToast(
                            msg: translate(context, 'copied_clipboard'));
                        MainScreen.showInterstitial();
                      },
                    ),
                    CuperIcon(
                      icon: Icons.web,
                      isBrowser: true,
                      text: translate(context, 'search'),
                      onPressed: () async {
                        if (widget.Qr.type == QR.URL) {
                          String url = widget.Qr.value.contains('http')
                              ? widget.Qr.value
                              : 'http://' + widget.Qr.value;
                          await FlutterWebBrowser.openWebPage(
                              url: url,
                              customTabsOptions: CustomTabsOptions(
                                  toolbarColor:
                                      Theme.of(context).primaryColor));
                        } else {
                          await FlutterWebBrowser.openWebPage(
                              url: "https://www.google.com/search?q=" +
                                  widget.Qr.value,
                              customTabsOptions: CustomTabsOptions(
                                  toolbarColor:
                                      Theme.of(context).primaryColor));
                        }
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 16),
                //   child: fullNativeAd(context),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      ClayContainer(
                        color: BlocProvider.of<ThemeCubit>(context).state.isDark
                            ? Colors.white
                            : Theme.of(context).canvasColor,
                        borderRadius: 16,
                        spread:
                            BlocProvider.of<ThemeCubit>(context).state.isDark
                                ? 0
                                : 10,
                        depth: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Screenshot(
                            controller: screenshotController,
                            child: Container(
                              color: BlocProvider.of<ThemeCubit>(context)
                                      .state
                                      .isDark
                                  ? Colors.white
                                  : Theme.of(context).canvasColor,
                              child: QrImage(
                                data: widget.Qr.value,
                                version: QrVersions.auto,
                                size: MediaQuery.of(context).size.width * 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CuperIcon(
                              icon: Icons.share_rounded,
                              text: translate(context, 'share'),
                              onPressed: () {
                                screenshotController
                                    .capture()
                                    .then((Uint8List? image) async {
                                  await WcFlutterShare.share(
                                      sharePopupTitle: 'share',
                                      fileName: 'qrCode.png',
                                      mimeType: 'image/png',
                                      bytesOfFile: image);
                                }).catchError((onError) {
                                  print(onError);
                                });
                                // MainScreen.showInterstitial();
                              }),
                          CuperIcon(
                              icon: Icons.save_alt_rounded,
                              text: translate(context, 'save'),
                              onPressed: () {
                                try {
                                  screenshotController
                                      .capture()
                                      .then((Uint8List? image) async {
                                    if (image != null) {
                                      await FileSaver.instance
                                          .saveAs(
                                              '${DateTime.now().toString()}.png',
                                              image,
                                              'png',
                                              MimeType.PNG)
                                          .then(
                                            (value) =>
                                                MainScreen.showInterstitial(),
                                          );
                                    }
                                  });
                                } catch (e) {}
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: MyBanner(),
        ),
      ),
    );
  }
}
