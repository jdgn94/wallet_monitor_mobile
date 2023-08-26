import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import "package:wallet_monitor/generated/l10n.dart";
import "package:wallet_monitor/src/bloc/global/global_bloc.dart";
import "package:wallet_monitor/src/bloc/settings/settings_bloc.dart";
import 'package:wallet_monitor/src/configs/theme.configs.dart';
import "package:wallet_monitor/src/db/services/database.service.dart";
import "package:wallet_monitor/src/routes/index.dart";
import "package:wallet_monitor/src/utils/fetch_controller.utils.dart";
import "package:wallet_monitor/storage/index.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsLocalStorage.configureSettings();
  await DatabaseService().database();

  final pref = SettingsLocalStorage.pref;

  runApp(AppState(pref: pref));
}

class AppState extends StatelessWidget {
  final SharedPreferences pref;

  const AppState({super.key, required this.pref});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()),
        BlocProvider<SettingsBloc>(create: (_) => SettingsBloc(pref: pref)),
      ],
      child: MyApp(pref: pref),
    );
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences pref;

  const MyApp({super.key, required this.pref});

  @override
  Widget build(BuildContext context) {
    FetchController.getAllCurrencies();

    final String initialPage = pref.getString("color") == null
        ? "/settingsInitial"
        : pref.getString("formatNumber") == null
            ? "/settingsSecondary"
            : "/home";

    // const String initialPage = "/settingsInitial";

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        print("Nombre del idioma ${state.lang}");
        return MaterialApp(
          title: "Wallet Monitor",
          debugShowCheckedModeBanner: false,
          theme: themeLight(colorSelected: state.color ?? '0'),
          darkTheme: themeDark(colorSelected: state.color ?? '0'),
          themeMode: _getThemeMode(state.theme ?? 'system'),
          routes: getApplicationRouters(),
          initialRoute: initialPage,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocaleNamesLocalizationsDelegate(),
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale.fromSubtags(
            languageCode: state.lang ?? 'und',
          ),
        );
      },
    );
  }

  ThemeMode _getThemeMode(String mode) {
    if (mode == 'dark') return ThemeMode.dark;
    if (mode == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }
}
