import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wallet_monitor/generated/l10n.dart';

import 'package:wallet_monitor/src/widgets/settings/color_selecteor.widget.dart';
import 'package:wallet_monitor/src/widgets/settings/theme_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.dart';
import 'package:wallet_monitor/storage/index.dart';

class SettingsInitialPage extends StatefulWidget {
  const SettingsInitialPage({super.key});

  @override
  State<SettingsInitialPage> createState() => _SettingsInitialPageState();
}

class _SettingsInitialPageState extends State<SettingsInitialPage> {
  final _pref = SettingsLocalStorage.pref;

  @override
  void initState() {
    _setInitialValueOnSharedPreferences();
    super.initState();
  }

  _setInitialValueOnSharedPreferences() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo(),
                ThemeSelectorWidget(pref: _pref),
                ColorSelectorWidget(pref: _pref),
                const SizedBox(
                  height: 15,
                ),
                _nextPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column logo() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              Positioned(
                top: 60,
                child: Icon(
                  Icons.settings,
                  size: 120,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 13.5,
                right: 0,
                child: Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: Icon(
                    Icons.settings,
                    size: 120,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          S.current.initialConfig,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _nextPage() {
    return CustomButton(
      onPressed: () => Navigator.of(context).pushNamed("/settingsSecondary"),
      text: 'Next Page',
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 60.0,
    );
  }
}
