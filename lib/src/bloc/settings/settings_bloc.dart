// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

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
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang") ?? Platform.localeName.split('_')[0],
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        )) {
    on<SettingsEvent>((event, emit) {
      if (event is ChangeTheme) {
        pref.setString("theme", event.theme);
        pref.setString("lightStyle", event.lightStyle);
        pref.setString("darkStyle", event.darkStyle);

        emit(SettingsState(
          event.theme,
          event.lightStyle,
          event.darkStyle,
          pref.getString("lang"),
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeLanguage) {
        pref.setString("lang", event.lang);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          event.lang,
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeColor) {
        pref.setString("color", event.color);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang"),
          event.color,
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeDefaultCurrency) {
        pref.setInt("defaultCurrency", event.defaultCurrency);
        pref.setString("currencySymbol", event.currencySymbol);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang"),
          pref.getString("color"),
          event.defaultCurrency,
          event.currencySymbol,
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeFormatNumber) {
        pref.setString("formatNumber", event.formatNumber);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          event.formatNumber,
          pref.getBool("showTutorial"),
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeShowTutorial) {
        pref.setBool("showTutorial", event.showTutorial);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          event.showTutorial,
          pref.getString("dateFormat"),
        ));
      }

      if (event is ChangeDateFormat) {
        pref.setString("dateFormat", event.dateFormat);

        emit(SettingsState(
          pref.getString("theme"),
          pref.getString("lightStyle"),
          pref.getString("darkStyle"),
          pref.getString("lang"),
          pref.getString("color"),
          pref.getInt("defaultCurrency"),
          pref.getString("currencySymbol"),
          pref.getString("formatNumber"),
          pref.getBool("showTutorial"),
          event.dateFormat,
        ));
      }
    });
  }
}
