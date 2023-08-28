// ignore_for_file: depend_on_referenced_packages, must_be_immutable, use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:wallet_monitor/src/bloc/global/global_bloc.dart';
import 'package:wallet_monitor/src/db/models/category.model.dart';
import 'package:wallet_monitor/src/db/queries/account.consult.dart';
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
  late List<Account?> accounts;
  late Account? account;
  List<String> keyValues = [];
  DateTime dateSelected = DateTime.now();
  List<String> allNumbers = ["0"];
  List<String> mathOperations = [];
  bool writingDecimal = false;
  bool secondaryNumberError = false;

  @override
  void initState() {
    definitiveNumber = widget.defaultValue ?? '0';
    _inputController = TextEditingController();
    currency = widget.currency;
    currencySymbol = currency.symbol;
    actualCurrencyId = currency.id;
    currencyDecimalDigits = currency.decimalDigits;
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
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _getFirstAccount() async {
    accounts = await AccountConsult.getAllNoDeleted();
    account = accounts.isEmpty ? null : accounts.first;

    setState(() {});
  }

  Future<void> _showKeyboard() async {
    allNumbers = <String>[];
    mathOperations = <String>[];
    allNumbers.add(definitiveNumber);
    await _getFirstAccount();

    showModalBottomSheet(
      context: context,
      builder: _keyboardType,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      showDragHandle: true,
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
    print(id);

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (context, snapshot) {
      print(actualCurrencyId);
      print(snapshot.newCurrency);
      if (snapshot.newCurrency != actualCurrencyId &&
          snapshot.newCurrency != null) {
        Future.delayed(
            Duration.zero, () => _refreshInput(snapshot.newCurrency!));
      }

      if (widget.type == KeyType.buttonCategory) {
        return CustomButton(
          onPressed: _showKeyboard,
          category: widget.category!,
          currency: currency,
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
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.end,
          children: [
            _totalNumber(),
            _categoryAccount(),
            Divider(
              height: 1.5,
              color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
            ),
            _keyboard(changeState),
            _dateSelectedInfo(),
          ],
        );
      }),
    );
  }

  Row _totalNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          CurrencyFunctions.formatNumber(
            amount: double.parse(allNumbers[0]),
            decimalDigits: currencyDecimalDigits,
            symbol: currencySymbol,
          ),
          style: const TextStyle(fontSize: 25.0),
        ),
        if (allNumbers.length > 1)
          Visibility(
            visible: allNumbers.length > 1,
            child: Row(
              children: [
                const SizedBox(width: 3),
                Icon(getIcon(mathOperations[0])),
                const SizedBox(width: 3),
                Text(
                  CurrencyFunctions.formatNumber(
                    amount: double.parse(allNumbers[1]),
                    decimalDigits: currencyDecimalDigits,
                    symbol: currencySymbol,
                  ),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: secondaryNumberError
                        ? Colors.red
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Row _categoryAccount() {
    // if (category) return Row();
    return Row();
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
            padding: const EdgeInsets.only(
                left: 7.0, right: 7.0, top: 7.0, bottom: 7.0),
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
}
