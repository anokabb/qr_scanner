import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/bloc/qr_bloc.dart';
import 'package:qr_scanner/screens/MainScreen.dart';
import 'Utils/Localization/app_localizations_setup.dart';
import 'cubit/internet_cubit.dart';
import 'cubit/locale_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'models/Themes.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: Connectivity())),
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
                home: BlocProvider(
                  create: (context) => QrBloc([]),
                  child: MainScreen(),
                ),
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                locale: Locale(localeState.langCode),
              );
            },
          );
        },
      ),
    );
  }
}
