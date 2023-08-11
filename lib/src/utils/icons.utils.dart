import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

IconData getIcon(String name) {
  switch (name) {
    case 'accounts':
      return MdiIcons.walletBifold;
    case 'noAccounts':
      return MdiIcons.walletBifoldOutline;
    case 'categories':
      return MdiIcons.shapePlus;
    case 'noCategories':
      return MdiIcons.shapePlusOutline;
    case 'operations':
      return MdiIcons.receiptText;
    case 'noOperations':
      return MdiIcons.receiptTextOutline;
    case 'statistics':
      return MdiIcons.chartBar;
    case 'noStatistics':
      return MdiIcons.chartBarStacked;
    case 'wallet':
      return Icons.wallet_rounded;
    case 'card':
      return MdiIcons.creditCardOutline;
    case 'saving':
      return Icons.savings_rounded;
    case 'cash':
      return MdiIcons.cash;
    case 'add':
      return Icons.add;
    case 'search':
      return Icons.search_rounded;
    case 'palette':
      return Icons.palette;
    case 'divider':
      return MdiIcons.division;
    case 'multiplication':
      return MdiIcons.close;
    case 'sum':
      return Icons.add;
    case 'minus':
      return MdiIcons.minus;
    case '0':
      return MdiIcons.numeric0;
    case '9':
      return MdiIcons.numeric9;
    case '8':
      return MdiIcons.numeric8;
    case '6':
      return MdiIcons.numeric6;
    case '7':
      return MdiIcons.numeric7;
    case '5':
      return MdiIcons.numeric5;
    case '4':
      return MdiIcons.numeric4;
    case '3':
      return MdiIcons.numeric3;
    case '2':
      return MdiIcons.numeric2;
    case '1':
      return MdiIcons.numeric1;
    case ',':
      return MdiIcons.comma;
    case '.':
      return MdiIcons.vectorPoint;
    case 'check':
      return MdiIcons.check;
    case 'equal':
      return MdiIcons.equal;
    case "delete":
      return MdiIcons.backspaceOutline;
    case "clear":
      return MdiIcons.alphaC;
    case "calendar":
      return MdiIcons.calendar;
    default:
      return Icons.question_mark_rounded;
  }
}
