import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/cubit/internet_cubit.dart';
import '../Utils/Localization/app_localizations.dart';
import '../db/database_provider.dart';
import '../models/QR.dart';
import '../cubit/flash_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MainScreen.dart';
import 'ResultScreen.dart';
import 'package:recognition_qrcode/recognition_qrcode.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    BlocProvider.of<InternetCubit>(context).stream.listen((event) {
      if (MainScreen.controller != null) {
        MainScreen.controller!.pauseCamera();
        MainScreen.controller!.resumeCamera();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashCubit(),
      child: BlocBuilder<FlashCubit, FlashState>(
        builder: (context, state) {
          return Stack(
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderWidth: 6,
                  overlayColor: Colors.black.withOpacity(0.35),
                  borderRadius: 20,
                ),
              ),
              Positioned(
                right: 10,
                left: 10,
                bottom: 20,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: pickImage,
                        child: Icon(
                          Icons.image_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          MainScreen.controller!.flipCamera();
                        },
                        child: Icon(
                          Icons.flip_camera_ios_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      BlocBuilder<FlashCubit, FlashState>(
                        builder: (context, state) {
                          return CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              MainScreen.controller!.toggleFlash();
                              MainScreen.controller!
                                  .getFlashStatus()
                                  .then((turnedOn) {
                                if (turnedOn!) {
                                  BlocProvider.of<FlashCubit>(context)
                                      .flashOn();
                                } else {
                                  BlocProvider.of<FlashCubit>(context)
                                      .flashOff();
                                }
                              });
                            },
                            child: Icon(
                              state is FlashOn
                                  ? Icons.flash_on_rounded
                                  : Icons.flash_off_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  elevation: 6,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future pickImage() async {
    final PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    try {
      Map map = await RecognitionQrcode.recognition(pickedFile!.path);
      String qrData = map['value'];

      if (qrData.isEmpty) {
        Fluttertoast.showToast(
          msg: translate(context, 'no_qr'),
        );
      } else {
        QR Qr = QR(value: qrData, isScanned: true);
        DatabaseProvider.db.insert(context, Qr);
        pushNewScreen(
          context,
          screen: ResultScreen(Qr),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: translate(context, 'no_qr'),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    MainScreen.controller = controller;
    log('ddd');
    controller.scannedDataStream.listen((scanData) async {
      log(scanData.toString());
      controller.pauseCamera();
      print(scanData);
      QR Qr = QR(value: scanData.code, isScanned: true);
      DatabaseProvider.db.insert(context, Qr);
      await pushNewScreen(
        context,
        screen: ResultScreen(Qr),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
      controller.resumeCamera();
    });
  }

  @override
  void dispose() {
    // MainScreen.controller!.dispose();
    super.dispose();
  }
}
