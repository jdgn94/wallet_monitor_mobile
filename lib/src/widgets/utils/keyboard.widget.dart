// ignore_for_file: depend_on_referenced_packages, must_be_immutable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:wallet_monitor/generated/l10n.dart';

import 'package:wallet_monitor/src/bloc/global/global_bloc.dart';
import 'package:wallet_monitor/src/db/queries/account.consult.dart';
import 'package:wallet_monitor/src/db/queries/category.consult.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';
import 'package:wallet_monitor/src/functions/utils.functions.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

enum KeyType { input, category, buttonCategory }

class KeyboardWidget extends StatefulWidget {
  SharedPreferences pref;
  Function(double) confirm;
  KeyType type;
  Category? category;
  Currency currency;
  String? label;
  String? defaultValue;
  bool activeCalendar;
  bool refreshWithGlobal;

  KeyboardWidget({
    super.key,
    required this.pref,
    required this.confirm,
    required this.type,
    required this.currency,
    this.category,
    this.label,
    this.defaultValue,
    this.activeCalendar = true,
    this.refreshWithGlobal = false,
  });

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  final today = DateTime.now();
  late TextEditingController _inputController;
  late String definitiveNumber;
  late String currencySymbol;
  late int actualCurrencyId;
  late int currencyDecimalDigits;
  late Currency currency;
  late Currency currencySecondary;
  late List<Account?> accounts;
  late Category? category;
  late List<Category?> categories;
  late Account? account;
  late Subcategory? subcategorySelected;
  List<String> keyValues = [];
  DateTime dateSelected = DateTime.now();
  List<String> allNumbers = [];
  List<String> mathOperations = [];
  bool writingDecimal = false;
  bool secondaryNumberError = false;

  @override
  void initState() {
    print("Hola vale");
    print(widget.pref.getString("formatNumber"));
    definitiveNumber = widget.defaultValue ?? '0';
    _inputController = TextEditingController();
    currency = widget.currency;
    currencySecondary = widget.currency;
    currencySymbol = currency.symbol;
    actualCurrencyId = currency.id;
    currencyDecimalDigits = currency.decimalDigits;
    allNumbers.add(widget.defaultValue ?? "0");
    print("datos recibidos en el teclado: $currencySymbol");
    keyValues = [
      "division",
      "7",
      "8",
      "9",
      "delete",
      "multiplication",
      "4",
      "5",
      "6",
      "clear",
      "subtract",
      "1",
      "2",
      "3",
      "calendar",
      "sum",
      "0",
      (widget.pref.getString("formatNumber") == "de_DE" ||
              widget.pref.getString("formatNumber") == "pl_PL")
          ? ","
          : ".",
      "check",
    ];
    _refreshInput(currency.id);
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _getFirstAccount() async {
    accounts = await AccountConsult.getAllNoDeleted(
        currencyPrimaryId: widget.currency.id);
    account = accounts.isEmpty ? null : accounts.first;
    category = widget.category;
    subcategorySelected = widget.category?.subcategories.length == 0
        ? null
        : widget.category?.subcategories.first;
    categories = await CategoryConsult.getAll(showDelete: false);

    setState(() {});
  }

  Future<void> _showKeyboard() async {
    allNumbers = <String>[];
    mathOperations = <String>[];
    allNumbers.add(definitiveNumber);
    if (widget.category != null) await _getFirstAccount();
    currencySecondary = currency;

    showModalBottomSheet(
      context: context,
      builder: _keyboardType,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      // showDragHandle: true,
    );
  }

  bool _valueIsNumber(String value) {
    return value == "1" ||
        value == "2" ||
        value == "3" ||
        value == "4" ||
        value == "5" ||
        value == "6" ||
        value == "7" ||
        value == "8" ||
        value == "9" ||
        value == "0" ||
        value == "," ||
        value == ".";
  }

  void _buttonAction(String value, StateSetter changeState) {
    if (value == 'calendar' && !widget.activeCalendar) return;
    if ((value == ',' || value == '.') && currencyDecimalDigits == 0) return;
    final isNumber = _valueIsNumber(value);

    if (isNumber) {
      if (writingDecimal && (value == ',' || value == ',')) return;
      if (value == ',' || value == ',') value = '.';
      final numberTmp = allNumbers[allNumbers.length - 1];
      if (writingDecimal) {
        if (value == '.') return;
        final decimalNumber = numberTmp.split('.');
        if (decimalNumber.length > 1) return;
      }
      allNumbers[allNumbers.length - 1] =
          numberTmp == '0' ? value : (numberTmp + value);
    } else {
      if (value == 'clear') {
        allNumbers = ["0"];
        mathOperations = [];
      } else if (value == "delete") {
        final numberTmp = allNumbers[allNumbers.length - 1];
        final characterToDelete = numberTmp[numberTmp.length - 1];
        if (characterToDelete == '.') writingDecimal = false;
        if (numberTmp.length == 1 && allNumbers.length > 1) {
          allNumbers.removeLast();
          mathOperations.removeLast();
          keyValues[keyValues.length - 1] = "check";
        } else {
          allNumbers[allNumbers.length - 1] = numberTmp.length == 1
              ? '0'
              : numberTmp.substring(0, numberTmp.length - 1);
        }
      } else if (value == "division" ||
          value == "multiplication" ||
          value == "subtract" ||
          value == "sum") {
        if (mathOperations.isNotEmpty) _calculateOperation(changeState);
        allNumbers.add("0");
        mathOperations.add(value);
        keyValues[keyValues.length - 1] = "equal";
      } else if (value == "equal") {
        _calculateOperation(changeState);
        keyValues[keyValues.length - 1] = "check";
      } else if (value == "check") {
        definitiveNumber = allNumbers[0];
        _inputController.text = CurrencyFunctions.formatNumber(
          symbol: currencySymbol,
          decimalDigits: currency.decimalDigits,
          amount: double.parse(definitiveNumber),
        );
        widget.confirm((double.parse(definitiveNumber)));
        Navigator.of(context).pop();
      }
    }

    setState(() {});
    changeState(() {});
  }

  Future<void> _refreshInput(int id) async {
    final currency = await CurrencyConsult.getById(id);
    print("Estoy referescando el input con el siguiente id de moneda $id");

    setState(() {
      currencySymbol = currency.symbol;
      actualCurrencyId = id;
      currencyDecimalDigits = currency.decimalDigits;
    });
    _inputController.text = CurrencyFunctions.formatNumber(
      amount: double.parse(allNumbers[0]),
      decimalDigits: currencyDecimalDigits,
      symbol: currencySymbol,
    );
  }

  void _calculateOperation(StateSetter changeState) {
    final firstNumber = double.parse(allNumbers[0]);
    final secondNumber = double.parse(allNumbers[1]);
    double result;
    if (mathOperations[0] == "sum") {
      result = firstNumber + secondNumber;
    } else if (mathOperations[0] == "subtract") {
      result = firstNumber - secondNumber;
      if (result < 0) {
        secondaryNumberError = true;
        return;
      }
    } else if (mathOperations[0] == "multiplication") {
      result = firstNumber * secondNumber;
    } else {
      if (secondNumber == 0) {
        secondaryNumberError = true;
        return;
      }
      result = firstNumber / secondNumber;
    }

    allNumbers.removeLast();
    allNumbers[0] = result.toString();
    mathOperations.removeLast();
    setState(() {});
    changeState(() {});
  }

  Color _getIconColor(String name) {
    if (name == 'calendar' && !widget.activeCalendar) {
      return Colors.blue.withAlpha(100);
    }

    if (name == 'equal' || name == 'calendar') return Colors.blue;

    if (name == 'check' ||
        name == 'sum' ||
        name == 'subtract' ||
        name == 'multiplication' ||
        name == 'division') {
      return Colors.green;
    }

    if (name == 'delete' || name == 'clear') return Colors.red;

    return Theme.of(context).colorScheme.onBackground;
  }

  Color _getButtonColor(String name) {
    if (name == 'equal' || name == 'calendar') {
      return Colors.blue;
    }
    if (name == 'check' ||
        name == 'sum' ||
        name == 'subtract' ||
        name == 'multiplication' ||
        name == 'division') {
      return Colors.green;
    }

    if (name == 'delete' || name == 'clear') return Colors.red;

    return Theme.of(context).colorScheme.primary;
  }

  Future<void> _openCategoryList(StateSetter changeState) async {
    categories = await CategoryConsult.getAll(showDelete: false);
    showDialog(
      context: context,
      builder: (context) => _dialogCategories(context, changeState),
    );
  }

  Future<void> _openAccountList(StateSetter changeState) async {
    accounts =
        (await AccountConsult.getAll(showDelete: false, ignoreTotal: true))
            .accounts;
    showDialog(
      context: context,
      builder: (context) => _dialogAccounts(context, changeState),
    );
  }

  Future<void> _changeSecondaryCurrency(int id) async {
    currencySecondary = await CurrencyConsult.getById(id);
  }

  void _openChangeExchangeRate() {
    print("Tengo que hacer el cambio de tasa");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (context, snapshot) {
      print(actualCurrencyId);
      print(snapshot.newCurrency);
      if (snapshot.newCurrency != actualCurrencyId &&
          widget.refreshWithGlobal &&
          snapshot.newCurrency != null) {
        Future.delayed(
            Duration.zero, () => _refreshInput(snapshot.newCurrency!));
      }

      if (widget.type == KeyType.buttonCategory) {
        return CustomButton(
          onPressed: _showKeyboard,
          category: widget.category!,
          currency: currency,
          margin: const EdgeInsets.only(top: 10),
          type: ButtonType.category,
        );
      }

      return TextField(
        readOnly: true,
        onTap: _showKeyboard,
        controller: _inputController,
        decoration: InputDecoration(
          label: Text(widget.label ?? ""),
        ),
      );
    });
  }

  Widget _keyboardType(BuildContext context) {
    return _fullScreenKeyboard();
  }

  FractionallySizedBox _fullScreenKeyboard() {
    return FractionallySizedBox(
      child: StatefulBuilder(builder: (context, changeState) {
        return SingleChildScrollView(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            children: [
              _categoryAccount(changeState),
              Row(
                children: [
                  _totalNumber(),
                  if (currencySecondary.id != currency.id)
                    _totalNumber(secondaryCurrency: true),
                ],
              ),
              _additionalButtons(),
              Divider(
                height: 1.5,
                color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
              ),
              _keyboard(changeState),
              _dateSelectedInfo(),
            ],
          ),
        );
      }),
    );
  }

  Widget _categoryAccount(StateSetter changeState) {
    if (widget.category == null) return const SizedBox();
    return Row(
      children: [
        _buttonCategory(changeState),
        _buttonAccount(changeState),
      ],
    );
  }

  Container _buttonCategory(StateSetter changeState) {
    final color = Color(int.parse("0x${category!.color}")).withAlpha(255);

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: InkWell(
        onTap: () => _openCategoryList(changeState),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 115,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.category,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(getIcon(category!.icon), color: color),
                  const SizedBox(width: 10),
                  Text(
                    category!.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withAlpha(50),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(subcategorySelected?.name ?? "No Subcategory"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buttonAccount(StateSetter changeState) {
    final color = Color(int.parse("0x${account!.color}")).withAlpha(255);

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: InkWell(
        onTap: () => _openAccountList(changeState),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 115,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.account,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(getIcon(account!.icon), color: color),
                  const SizedBox(width: 10),
                  Text(
                    account!.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  CurrencyFunctions.name(account!.currencyName),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _totalNumber({bool secondaryCurrency = false}) {
    final bool towCurrencies = currencySecondary.id != currency.id;

    return InkWell(
      onTap: secondaryCurrency ? () => _openChangeExchangeRate() : null,
      child: Ink(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width / (towCurrencies ? 2 : 1),
        decoration: BoxDecoration(
          gradient: secondaryCurrency
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.2, 0.7],
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.primary.withAlpha(60),
                  ],
                )
              : null,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Text(
              CurrencyFunctions.formatNumber(
                amount: secondaryCurrency
                    ? double.parse(allNumbers[0]) /
                        currency.exchangeRate *
                        currencySecondary.exchangeRate
                    : double.parse(allNumbers[0]),
                decimalDigits: secondaryCurrency
                    ? currencySecondary.decimalDigits
                    : currencyDecimalDigits,
                symbol: secondaryCurrency
                    ? currencySecondary.symbol
                    : currencySymbol,
              ),
              style: const TextStyle(fontSize: 20.0),
            ),
            if (allNumbers.length > 1)
              Visibility(
                visible: allNumbers.length > 1,
                child: Wrap(
                  children: [
                    const SizedBox(width: 3),
                    Icon(getIcon(mathOperations[0])),
                    const SizedBox(width: 3),
                    Text(
                      CurrencyFunctions.formatNumber(
                        amount: secondaryCurrency
                            ? double.parse(allNumbers[1]) /
                                currency.exchangeRate *
                                currencySecondary.exchangeRate
                            : double.parse(allNumbers[1]),
                        decimalDigits: secondaryCurrency
                            ? currencySecondary.decimalDigits
                            : currencyDecimalDigits,
                        symbol: secondaryCurrency
                            ? currencySecondary.symbol
                            : currencySymbol,
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: secondaryNumberError
                            ? Colors.red
                            : Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _additionalButtons() {
    if (widget.category == null) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonExtra(
            message: S.current.tax,
            icon: "bankOutline",
            right: true,
          ),
          _buttonExtra(
            message: S.current.observation,
            icon: "commentTextOutline",
          ),
          _buttonExtra(
            message: S.current.commission,
            icon: "percentOutline",
            left: true,
          ),
          _buttonExtra(
            message: S.current.image,
            icon: "cameraOutline",
            icon2: "imageOutline",
            left: true,
          ),
        ],
      ),
    );
  }

  Tooltip _buttonExtra({
    required String message,
    required String icon,
    String? icon2,
    bool left = false,
    bool right = false,
  }) {
    return Tooltip(
      message: message,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        constraints: const BoxConstraints(maxWidth: 155),
        child: InkWell(
          onTap: () {},
          child: Ink(
            width: MediaQuery.of(context).size.width / 4,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: right
                      ? Theme.of(context).colorScheme.onBackground.withAlpha(60)
                      : Colors.transparent,
                  width: 1,
                ),
                left: BorderSide(
                  color: left
                      ? Theme.of(context).colorScheme.onBackground.withAlpha(60)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(getIcon(icon)),
                if (icon2 != null) const Text("/"),
                if (icon2 != null) Icon(getIcon(icon2)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _keyboard(StateSetter changeState) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 315,
            constraints: const BoxConstraints(
              maxWidth: 615,
            ),
            padding: const EdgeInsets.all(7.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: keyValues
                  .map((e) => _keyboardButton(e, changeState))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Padding _keyboardButton(String iconName, StateSetter changeState) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => _buttonAction(iconName, changeState),
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: iconName == "0" ? 230 : 110,
            maxHeight: 85,
            minWidth: 52.8,
          ),
          child: Ink(
            width: MediaQuery.of(context).size.width *
                    .2 *
                    (iconName == '0' ? 2 : 1) -
                (iconName == '0' ? 20 : 15),
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(
                color: _getButtonColor(iconName),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor.withAlpha(240),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: _getButtonColor(iconName),
                  spreadRadius: -3,
                )
              ],
            ),
            child: Icon(
              getIcon(iconName),
              size: iconName == ',' || iconName == '.'
                  ? 12
                  : iconName == 'division' ||
                          iconName == 'multiplication' ||
                          iconName == 'subtract' ||
                          iconName == 'sum'
                      ? 27
                      : 35,
              color: _getIconColor(iconName),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateSelectedInfo() {
    return Visibility(
      visible: widget.activeCalendar,
      child: Column(
        children: [
          Divider(
            height: 0.5,
            color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
          ),
          Text(
            dateFormat(dateSelected, separator: "/"),
          ),
        ],
      ),
    );
  }

  AlertDialog _dialogCategories(BuildContext context, StateSetter changeState) {
    return AlertDialog(
      title: Text(S.current.categories),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              children: categories
                  .map((e) =>
                      _listItem(categoryItem: e, changeState: changeState))
                  .toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(S.current.cancel),
        ),
      ],
    );
  }

  AlertDialog _dialogAccounts(BuildContext context, StateSetter changeState) {
    return AlertDialog(
      title: Text(S.current.accounts),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              children: accounts
                  .map((e) =>
                      _listItem(accountItem: e, changeState: changeState))
                  .toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(S.current.cancel),
        ),
      ],
    );
  }

  Padding _listItem({
    Category? categoryItem,
    Account? accountItem,
    required StateSetter changeState,
  }) {
    final color = Color(int.parse(
            "0x${categoryItem?.color ?? accountItem?.color ?? '000000'}"))
        .withAlpha(255);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () async {
          if (categoryItem != null) {
            setState(() {
              category = categoryItem;
              subcategorySelected = categoryItem.subcategories.isEmpty
                  ? null
                  : categoryItem.subcategories.first;
            });
          }
          if (accountItem != null) {
            await _changeSecondaryCurrency(accountItem.currencyId);
            setState(() {
              account = accountItem;
            });
          }
          changeState(() {});
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: Row(
              children: [
                Ink(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: color.withAlpha(50),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        getIcon(categoryItem?.icon ?? accountItem?.icon ?? ''),
                        color: color,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryItem?.name ?? accountItem?.name ?? 'No name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${S.current.description}: ${categoryItem?.description ?? accountItem?.description ?? 'No description'}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (categoryItem != null)
                          Text(
                            "${S.current.totalSubcategories}: ${categoryItem.subcategories.length}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (accountItem != null)
                          Text(CurrencyFunctions.formatNumber(
                            amount: accountItem.amount,
                            decimalDigits: accountItem.decimalDigits,
                            symbol: accountItem.currencySymbol,
                          ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
