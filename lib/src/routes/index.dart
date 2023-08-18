import 'package:flutter/widgets.dart';
import 'package:wallet_monitor/src/pages/account_edition.page.dart';

import 'package:wallet_monitor/src/pages/home/index.page.dart';
import 'package:wallet_monitor/src/pages/settings.page.dart';
import 'package:wallet_monitor/src/pages/settings_initial.page.dart';
import 'package:wallet_monitor/src/pages/settings_second.page.dart';

Map<String, WidgetBuilder> getApplicationRouters() {
  return <String, WidgetBuilder>{
    "/settingsInitial": (context) => const SettingsInitialPage(),
    "/settingsSecondary": (context) => const SettingsSecondPage(),
    "/home": (context) => const HomePage(),
    "/account": (context) => const AccountEditionPage(),
    "/settings": (context) => const SettingsPage(),
  };
}
