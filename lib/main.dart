import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/MainScreen/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        canvasColor: Color(0xFFF2F2F2),
      ),
      themeMode: ThemeMode.light,
      home: MainScreen(),
    );
  }
}
