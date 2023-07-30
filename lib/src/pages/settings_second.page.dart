import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/widgets/settings/currency_selector.widget.dart';

import 'package:wallet_monitor/src/widgets/settings/format_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widgets.dart';
import 'package:wallet_monitor/storage/index.dart';

class SettingsSecondPage extends StatefulWidget {
  const SettingsSecondPage({Key? key}) : super(key: key);

  @override
  State<SettingsSecondPage> createState() => _SettingsSecondPageState();
}

class _SettingsSecondPageState extends State<SettingsSecondPage> {
  final _pref = SettingsLocalStorage.pref;

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
                SizedBox(height: MediaQuery.of(context).size.height * .09),
                CurrencySelectorWidget(pref: _pref),
                SizedBox(height: MediaQuery.of(context).size.height * .09),
                FormatSelectorWidget(pref: _pref),
                SizedBox(height: MediaQuery.of(context).size.height * .09),
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
        Container(
          margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
          width: 190,
          height: 160,
          child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 25,
                child: Icon(
                  MdiIcons.currencyJpy,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 15,
                right: 40,
                child: Icon(
                  MdiIcons.currencyEur,
                  size: 55,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 30,
                right: 25,
                child: Icon(
                  MdiIcons.currencyFra,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 65,
                left: 12,
                child: Icon(
                  MdiIcons.currencyRupee,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 50,
                left: 50,
                child: Icon(
                  MdiIcons.currencyUsd,
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 75,
                right: 55,
                child: Icon(
                  MdiIcons.currencyMnt,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                top: 60,
                right: 15,
                child: Text(
                  "Bs",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 30,
                child: Icon(
                  MdiIcons.currencyCny,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Positioned(
                bottom: 15,
                right: 50,
                child: Icon(
                  MdiIcons.currencyBrl,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Text(
          S.current.currencyConfig,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  CustomButton _nextPage() {
    return CustomButton(
      onPressed: () => Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
      text: S.current.start,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 60.0,
    );
  }
}
