import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

import "package:wallet_monitor/storage/index.dart";

part "settings_event.dart";
part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences pref;

  SettingsBloc({required this.pref})
      : super(SettingsInitial(
          pref.getString("theme"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getInt("defaultCurrency"),
        )) {
    on<SettingsEvent>((event, emit) {
      if (event is ChangeTheme) {
        pref.setString("theme", event.theme);

        emit(SettingsState(
          event.theme,
          pref.getString("lang"),
          pref.getString("color"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getInt("defaultCurrency"),
        ));
      }

      if (event is ChangeLanguage) {
        pref.setString("lang", event.lang);

        emit(SettingsState(
          pref.getString("theme"),
          event.lang,
          pref.getString("color"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getInt("defaultCurrency"),
        ));
      }

      if (event is ChangeColor) {
        pref.setString("color", event.color);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lang"),
          event.color,
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getInt("defaultCurrency"),
        ));
      }

      if (event is ChangeFormatNumber) {
        pref.setString("formatNumber", event.formatNumber);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lang"),
          pref.getString("color"),
          event.formatNumber,
          pref.getBool("showTutorial"),
          pref.getInt("defaultCurrency"),
        ));
      }

      if (event is ChangeShowTutorial) {
        pref.setBool("showTutorial", event.showTutorial);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getString("formatNumber"),
          event.showTutorial,
          pref.getInt("defaultCurrency"),
        ));
      }

      if (event is ChangeDefaultCurrency) {
        pref.setInt("defaultCurrency", event.defaultCurrency);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          event.defaultCurrency,
        ));
      }
    });
  }
}
