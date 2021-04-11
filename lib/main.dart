import 'package:flutter/material.dart';
import 'screens/MainScreen.dart';

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
        primaryColor: Color.fromRGBO(98, 0, 238, 1),
        accentColor: Color.fromRGBO(98, 0, 238, 1),
        // primaryColor: Color.fromRGBO(91, 53, 141, 1),
        backgroundColor: Colors.white,
        canvasColor: Color(0xFFF2F2F2),
      ),
      themeMode: ThemeMode.light,
      home: MainScreen(),
    );
  }
}
