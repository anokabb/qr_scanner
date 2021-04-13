import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/Utils/Localization/app_localizations_setup.dart';
import 'package:qr_scanner/cubit/locale_cubit.dart';
import 'package:qr_scanner/cubit/theme_cubit.dart';
import 'package:qr_scanner/models/Themes.dart';
import 'screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (_, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
            builder: (_, localeState) {
              return MaterialApp(
                title: 'QR Scanner',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightThemeData,
                darkTheme: AppThemes.darkThemeData,
                themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
                home: MainScreen(),
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                locale: Locale(localeState.localeCode),
              );
            },
          );
        },
      ),
    );
  }
}
