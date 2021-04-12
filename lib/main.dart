import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/cubit/theme_cubit.dart';
import 'Utils/Translate.dart';
import 'models/Languages.dart';
import 'screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Translate.instance!.setLanguage(Languages.ENGLISH_STR);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData lightThemeData = ThemeData(
    primaryColor: Color.fromRGBO(98, 0, 238, 1),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(98, 0, 238, 1)),
    backgroundColor: Colors.white,
    splashColor: Colors.black,
    buttonColor: Colors.white,
    canvasColor: Color(0xFFF2F2F2),
  );

  ThemeData darkThemeData = ThemeData(
    primaryColor: Color.fromRGBO(98, 0, 238, 1),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(44, 44, 44, 1)),
    backgroundColor: Colors.black,
    splashColor: Colors.white,
    buttonColor: Color.fromRGBO(44, 44, 44, 1),
    canvasColor: Color.fromRGBO(44, 44, 44, 1),
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'QR Scanner',
            debugShowCheckedModeBanner: false,
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
