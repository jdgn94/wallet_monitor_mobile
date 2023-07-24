part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final String? theme;
  final String? lightStyle;
  final String? darkStyle;
  final String? lang;
  final String? color;
  final String? formatNumber;
  final bool? showTutorial;
  final int? defaultCurrency;

  const SettingsState(
    this.theme,
    this.lightStyle,
    this.darkStyle,
    this.lang,
    this.color,
    this.formatNumber,
    this.showTutorial,
    this.defaultCurrency,
  );

  @override
  List<Object?> get props => [
        theme,
        lightStyle,
        darkStyle,
        lang,
        color,
        formatNumber,
        showTutorial,
        defaultCurrency,
      ];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(
    super.theme,
    super.lightStyle,
    super.darkStyle,
    super.lang,
    super.color,
    super.formatNumber,
    super.showTutorial,
    super.defaultCurrency,
  );
}
