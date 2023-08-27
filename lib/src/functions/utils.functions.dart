import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/storage/index.dart';

enum DateTypeFormat {
  number,
  monthString,
  dayString,
  monthAndDayString,
  dayAndMonthOnly,
  monthAndYearOnly,
  monthStringAndYearOnly
}

String translateMonth(int month) {
  switch (month) {
    case 1:
      return S.current.january;
    case 2:
      return S.current.february;
    case 3:
      return S.current.march;
    case 4:
      return S.current.april;
    case 5:
      return S.current.may;
    case 6:
      return S.current.jun;
    case 7:
      return S.current.july;
    case 8:
      return S.current.august;
    case 9:
      return S.current.september;
    case 10:
      return S.current.october;
    case 11:
      return S.current.november;
    case 12:
      return S.current.december;
    default:
      return "Month not found";
  }
}

String dateFormat(
  DateTime date, {
  DateTypeFormat dateType = DateTypeFormat.number,
  String separator = " ",
}) {
  switch (dateType.name) {
    case "monthString":
      return _formatDate(
        date.year.toString(),
        translateMonth(date.month),
        "${date.day < 10 ? '0' : ''}${date.day}",
        separator,
      );
    case "monthStringAndYearOnly":
      return _formatDate(
        date.year.toString(),
        translateMonth(date.month),
        "",
        separator,
      );
    default:
      return _formatDate(
        date.year.toString(),
        "${date.month < 10 ? '0' : ''}${date.month}",
        "${date.day < 10 ? '0' : ''}${date.day}",
        separator,
      );
  }
}

String _formatDate(String year, String month, String day, String separator) {
  final pref = SettingsLocalStorage.pref;
  final formatType = pref.getString("dateFormat");

  switch (formatType) {
    case "us":
      return "$month$separator$day$separator$year";
    case "es":
      return "$day$separator$month$separator$year";
    default:
      return "$year$separator$month$separator$day";
  }
}
