import 'package:wallet_monitor/generated/l10n.dart';

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
