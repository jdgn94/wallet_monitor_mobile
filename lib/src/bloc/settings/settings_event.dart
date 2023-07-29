part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends SettingsEvent {
  final String theme;
  final String lightStyle;
  final String darkStyle;

  const ChangeTheme(
    this.theme,
    this.lightStyle,
    this.darkStyle,
  );
}

class ChangeLanguage extends SettingsEvent {
  final String lang;

  const ChangeLanguage(this.lang);
}

class ChangeColor extends SettingsEvent {
  final String color;

  const ChangeColor(this.color);
}

class ChangeFormatNumber extends SettingsEvent {
  final String formatNumber;

  const ChangeFormatNumber(this.formatNumber);
}

class ChangeShowTutorial extends SettingsEvent {
  final bool showTutorial;

  const ChangeShowTutorial(this.showTutorial);
}
