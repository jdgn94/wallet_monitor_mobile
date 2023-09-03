import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/bloc/global/global_bloc.dart';
import 'package:wallet_monitor/src/db/queries/account.consult.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/db/models/navigator_returned.dart';
import 'package:wallet_monitor/src/functions/snack_bar.function.dart';
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
  Account? account;
  bool currencyLoad = false;
  bool loading = false;
  double amount = 0;
  double minAmount = 0;
  Currency currency = Currency(
    code: '',
    decimalDigits: 0,
    exchangeRate: 1,
    id: 0,
    name: '',
    symbol: '',
  );
  String iconAccount = 'none';
  Color colorAccount =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(250);
  bool editing = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    currencyId = _pref.getInt("defaultCurrency") ?? 103;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _getArguments() {
    account = ModalRoute.of(context)!.settings.arguments as Account?;

    if (account != null) {
      setState(() {
        currencyId = account!.currencyId;
        _nameController.text = account!.name;
        _descriptionController.text = account!.description!;
        iconAccount = account!.icon;
        colorAccount = Color(int.parse("0x${account!.color}"));
        amount = account!.amount;
        minAmount = account!.minAmount;
        editing = true;
      });
    }
  }

  Future<void> _getCurrency() async {
    loading = true;
    print("currency id desde el get currency del account edition $currencyId");
    currency = await CurrencyConsult.getById(currencyId);
    print("currency obtenido: ${currency.id}");
    setState(() {
      currencyLoad = true;
    });
  }

  void _selectIcon(Color newColor, String newIcon) {
    setState(() {
      colorAccount = newColor;
      iconAccount = newIcon;
    });
  }

  void _changeCurrency(Currency newCurrency) {
    BlocProvider.of<GlobalBloc>(context).add(ChangeNewCurrency(
      newCurrency.id,
    ));
    setState(() {
      currency = newCurrency;
      currencyId = newCurrency.id;
    });
  }

  bool _checkValues() {
    return _nameController.text.isEmpty || iconAccount == "none";
  }

  void _changeInitValue(double newValue) {
    setState(() {
      amount = newValue;
    });
  }

  void _changeMinAmount(double newValue) {
    setState(() {
      minAmount = newValue;
    });
  }

  Future<void> _saveAccount() async {
    try {
      await AccountConsult.createOrUpdate(
        id: account?.id,
        minAmount: minAmount,
        amount: amount,
        color: colorAccount
            .toString()
            .replaceAll("Color(0x", "")
            .replaceAll(")", ""),
        currencyId: currency.id,
        description: _descriptionController.text,
        icon: iconAccount,
        name: _nameController.text,
        createdAt: DateTime.now(),
      );

      final response = CreateReturner(reload: true);
      Navigator.of(context).pop(response);
    } catch (e) {
      showMessage(context: context, type: Type.error, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currencyLoad == false && loading == false) {
      _getArguments();
      _getCurrency();
    }

    return Scaffold(
      appBar: _appBar(),
      body: Visibility(
        visible: currencyLoad,
        replacement: const CircularProgressIndicator(),
        child: _body(),
      ),
    );
  }

  PreferredSize _appBar() {
    final usePrimaryColor = _pref.getString("color") == "7" ? false : true;

    return PreferredSize(
      preferredSize: const Size(double.infinity, 50),
      child: AppBar(
        title: Text(S.current.createAccount),
        centerTitle: true,
        foregroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.onPrimary : null,
        backgroundColor: usePrimaryColor
            ? Theme.of(context).colorScheme.primary
            : colorAccount.withAlpha(255),
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
              IconSelectorWidget(
                confirm: _selectIcon,
                defaultColor: colorAccount,
                defaultIcon: iconAccount,
              ),
              _spacing(),
              // _currencyInput(),
              CurrencySelectorWidget(
                pref: _pref,
                localSelect: true,
                defaultCurrency: currencyId,
                confirm: _changeCurrency,
                disabled: editing,
              ),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.amount,
                defaultValue: amount.toString(),
                currency: currency,
                confirm: _changeInitValue,
                activeCalendar: false,
              ),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.minimumAmount,
                defaultValue: minAmount.toString(),
                currency: currency,
                confirm: _changeMinAmount,
                activeCalendar: false,
              ),
              _spacing(),
              if (editing) _buttonToCancel(),
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

  TextField _nameInput() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        label: Text(S.current.name),
      ),
    );
  }

  TextField _descriptionInput() {
    return TextField(
      controller: _descriptionController,
      decoration: InputDecoration(
        label: Text(S.current.description),
      ),
      minLines: 1,
      maxLines: 3,
    );
  }

  CustomButton _buttonToCancel() {
    return CustomButton(
      onPressed: Navigator.of(context).pop,
      margin: const EdgeInsets.only(bottom: 10.0),
      type: ButtonType.outline,
      color: Colors.red,
      text: S.current.cancel,
      height: 50,
      size: 20,
    );
  }

  CustomButton _buttonToSave() {
    final usePrimaryColor = _pref.getString("color") == "7" ? false : true;
    return CustomButton(
      color: usePrimaryColor ? null : colorAccount,
      onPressed: _saveAccount,
      text: editing ? S.current.edit : S.current.create,
      height: 50,
      size: 20,
      disabled: _checkValues(),
    );
  }
}
