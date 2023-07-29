import 'package:flutter/widgets.dart';

import 'package:wallet_monitor/src/pages/home.page.dart';
import 'package:wallet_monitor/src/pages/settings_initial.page.dart';
import 'package:wallet_monitor/src/pages/settings_second.page.dart';

Map<String, WidgetBuilder> getApplicationRouters() {
  return <String, WidgetBuilder>{
    "/settingsInitial": (context) => const SettingsInitialPage(),
    "/settingsSecondary": (context) => const SettingsSecondPage(),
    "/home": (context) => const HomePage()
  };
}
