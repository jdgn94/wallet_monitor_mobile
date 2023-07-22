part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final String? theme;
  final String? lang;
  final String? color;
  final String? formatNumber;
  final bool? showTutorial;
  final int? defaultCurrency;

  const SettingsState(
    this.theme,
    this.lang,
    this.color,
    this.formatNumber,
    this.showTutorial,
    this.defaultCurrency,
  );

  @override
  List<Object?> get props => [
        theme,
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
    super.lang,
    super.color,
    super.formatNumber,
    super.showTutorial,
    super.defaultCurrency,
  );
}
