import 'package:shared_preferences/shared_preferences.dart';

export 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalStorage {
  static late SharedPreferences pref;

  SettingsLocalStorage();

  static Future<void> configureSettings() async {
    pref = await SharedPreferences.getInstance();
  }

  SharedPreferences get configPref => pref;
}
