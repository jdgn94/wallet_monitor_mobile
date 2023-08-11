import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/consults/currency.consult.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/settings/currency_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/icon_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/keyboard.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class AccountEditionPage extends StatefulWidget {
  const AccountEditionPage({super.key});

  @override
  State<AccountEditionPage> createState() => _AccountEditionPageState();
}

class _AccountEditionPageState extends State<AccountEditionPage> {
  final _pref = SettingsLocalStorage.pref;

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late int currencyId;
  int amount = 0;
  int minAmount = 0;
  Currency? currency;
  String iconCategory = 'none';
  Color colorCategory =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    currencyId = _pref.getInt("defaultCurrency") ?? 103;
    _getCurrency();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _getCurrency() async {
    currency = await CurrencyConsult.getById(currencyId);
    setState(() {});
  }

  void _selectIcon(Color newColor, String newIcon) {
    setState(() {
      colorCategory = newColor;
      iconCategory = newIcon;
    });
  }

  void _changeCurrency(Currency newCurrency) {
    setState(() {
      currency = newCurrency;
      currencyId = newCurrency.id;
    });
  }

  bool _checkValues() {
    return _nameController.text.isEmpty || iconCategory == "none";
  }

  void _changeInitValue(int newValue) {
    setState(() {
      amount = newValue;
    });
  }

  void _changeMinAmount(int newValue) {
    setState(() {
      minAmount = newValue;
    });
  }

  Future<void> _saveAccount() async {
    print(_nameController.text);
    print(_descriptionController.text);
    print(currency?.name);
    print(amount);
    print(minAmount);
  }

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
        title: Text(S.current.createAccount),
        centerTitle: true,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              _nameInput(),
              _spacing(),
              _descriptionInput(),
              _spacing(),
              // _iconInput(),
              IconSelectorWidget(confirm: _selectIcon),
              _spacing(),
              // _currencyInput(),
              CurrencySelectorWidget(
                pref: _pref,
                localSelect: true,
                defaultCurrency: currencyId,
                confirm: _changeCurrency,
              ),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.amount,
                currency: currency,
                confirm: _changeInitValue,
                activeCalendar: false,
              ),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.minimumAmount,
                currency: currency,
                confirm: _changeMinAmount,
                activeCalendar: false,
              ),
              _spacing(),
              _buttonToSave(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _spacing() {
    return const SizedBox(height: 40.0);
  }

  Widget _nameInput() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        label: Text(S.current.name),
      ),
    );
  }

  Widget _descriptionInput() {
    return TextField(
      controller: _descriptionController,
      decoration: InputDecoration(
        label: Text(S.current.description),
      ),
      minLines: 1,
      maxLines: 3,
    );
  }

  Widget _buttonToSave() {
    return CustomButton(
      onPressed: _saveAccount,
      text: S.current.create,
      icon: getIcon("save"),
      height: 50,
      size: 20,
      disabled: _checkValues(),
    );
  }
}
