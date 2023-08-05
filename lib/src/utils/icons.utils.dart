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
      return Icons.add_rounded;
    default:
      return Icons.question_mark_rounded;
  }
}
