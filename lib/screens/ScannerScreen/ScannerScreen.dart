import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/cubit/cubit/flash_cubit.dart';

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
            right: 0,
            left: 0,
            bottom: 10,
            child: Card(
              child: Row(
                children: <Widget>[
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(Icons.image_rounded),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      controller.flipCamera();
                    },
                    child: Icon(Icons.flip_camera_ios_outlined),
                  ),
                  BlocProvider(
                    create: (context) => FlashCubit(),
                    child: BlocBuilder<FlashCubit, FlashState>(
                      builder: (context, state) {
                        return CupertinoButton(
                          onPressed: () {
                            controller.toggleFlash();
                            controller.getFlashStatus().then((turnedOn) {
                              if (turnedOn!) {
                                BlocProvider.of<FlashCubit>(context).flashOn();
                              } else {
                                BlocProvider.of<FlashCubit>(context).flashOff();
                              }
                            });
                          },
                          child: Icon(state is FlashOn
                              ? Icons.flash_on_rounded
                              : Icons.flash_off_rounded),
                        );
                      },
                    ),
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
              margin: EdgeInsets.all(8),
            ),
          )
        ],
      ),
    );
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
