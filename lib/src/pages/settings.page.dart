import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/widgets/settings/color_selecteor.widget.dart';
import 'package:wallet_monitor/src/widgets/settings/currency_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/settings/format_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/settings/language_selector.wifget.dart';
import 'package:wallet_monitor/src/widgets/settings/theme_selector.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _pref = SettingsLocalStorage.pref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    final usePrimaryColor = _pref.getString("color") == "7" ? false : true;

    return PreferredSize(
      preferredSize: const Size(double.infinity, 50),
      child: AppBar(
        title: Text(S.current.settings),
        centerTitle: true,
        foregroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.onPrimary : null,
        backgroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }

  GestureDetector _body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            ThemeSelectorWidget(pref: _pref),
            ColorSelectorWidget(pref: _pref),
            CurrencySelectorWidget(pref: _pref, disabled: true),
            FormatSelectorWidget(pref: _pref),
            LanguageSelectorWidget(pref: _pref),
          ],
        ),
      ),
    );
  }
}
