import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/flash_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ResultScreen/ResultScreen.dart';

class ScannerScreen extends StatefulWidget {
  ScannerScreen();

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FlashCubit(),
        child: BlocBuilder<FlashCubit, FlashState>(builder: (context, state) {
          return Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.white,
                    borderWidth: 6,
                    overlayColor: Colors.black.withOpacity(0.3),
                    borderRadius: 20,
                  ),
                ),
                Positioned(
                  right: 10,
                  left: 10,
                  bottom: 20,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: pickImage,
                          child: Icon(Icons.image_rounded),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.flipCamera();
                          },
                          child: Icon(Icons.flip_camera_ios_outlined),
                        ),
                        BlocBuilder<FlashCubit, FlashState>(
                          builder: (context, state) {
                            return CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                controller.toggleFlash();
                                controller.getFlashStatus().then((turnedOn) {
                                  if (turnedOn!) {
                                    BlocProvider.of<FlashCubit>(context)
                                        .flashOn();
                                  } else {
                                    BlocProvider.of<FlashCubit>(context)
                                        .flashOff();
                                  }
                                });
                              },
                              child: Icon(state is FlashOn
                                  ? Icons.flash_on_rounded
                                  : Icons.flash_off_rounded),
                            );
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          );
        }));
  }

  Future pickImage() async {
    final PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    String qrData = await FlutterQrReader.imgScan(pickedFile!.path);
    print('qrData : $qrData');
    if (qrData.isEmpty) {
      Fluttertoast.showToast(
        msg: 'No Qr code found',
      );
    } else {
      pushNewScreen(
        context,
        screen: ResultScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.slideUp,
      );
      // Fluttertoast.showToast(
      //   msg: qrData,
      //   backgroundColor: Colors.green,
      // );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
