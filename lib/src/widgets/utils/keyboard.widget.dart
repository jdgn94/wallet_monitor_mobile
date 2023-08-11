// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:wallet_monitor/src/db/models/currency.model.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/storage/index.dart';

enum KeyType { input, category }

class KeyboardWidget extends StatefulWidget {
  SharedPreferences pref;
  Function(int) confirm;
  KeyType type;
  Currency? currency;
  String? label;
  String? defaultValue;
  bool activeCalendar;

  KeyboardWidget({
    super.key,
    required this.pref,
    required this.confirm,
    required this.type,
    this.currency,
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
  late String number;
  List<String> leftKeys = [];
  DateTime dateSelected = DateTime.now();
  List<String> numbers = ["0"];
  List<String> operation = [];
  bool writingDecimal = false;

  @override
  void initState() {
    number = widget.defaultValue ?? '0';
    _inputController = TextEditingController();
    leftKeys = [
      "divider",
      "7",
      "8",
      "9",
      "delete",
      "multiplication",
      "4",
      "5",
      "6",
      "clear",
      "minus",
      "1",
      "2",
      "3",
      "calendar",
      "sum",
      "0",
      widget.pref.getString("formatNumber") == "de_DE" ? "," : ".",
      "check",
    ];
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _showKeyboard() {
    showModalBottomSheet(
      context: context,
      builder: _keyboard,
      isDismissible: true,
    );
  }

  String _dateDif() {
    if (dateSelected.day == today.day &&
        dateSelected.month == today.month &&
        dateSelected.year == today.year) {
      return "Today, ";
    }

    return "";
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

  void _buttonAction(String value) {
    if (value == 'calendar' && !widget.activeCalendar) return;
    final number = _valueIsNumber(value);
    print(value);
    print(number);
  }

  Color _getIconColor(String name) {
    if (name == 'calendar' && !widget.activeCalendar) {
      return Colors.blue.withAlpha(100);
    }

    if (name == 'calendar') return Colors.blue;

    if (name == 'check' ||
        name == 'equal' ||
        name == 'sum' ||
        name == 'minus' ||
        name == 'multiplication' ||
        name == 'divider') {
      return Colors.green;
    }

    if (name == 'delete' || name == 'clear') return Colors.red;

    return Theme.of(context).colorScheme.onBackground;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: _showKeyboard,
      decoration: InputDecoration(
        label: Text(widget.label ?? ""),
      ),
    );
  }

  Widget _keyboard(BuildContext context) {
    print(MediaQuery.of(context).size);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            Text(
              "${widget.currency?.symbol ?? '\$'}\t${NumberFormat("#,##0.00", widget.pref.getString("formatNumber")!).format(double.parse(number))}",
              style: const TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 0.5,
              color: Theme.of(context).colorScheme.onBackground.withAlpha(60),
            ),
            SizedBox(
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
                      children:
                          leftKeys.map((e) => _keyboardButton(e)).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: widget.activeCalendar,
                child: Column(
                  children: [
                    Divider(
                      height: 0.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withAlpha(60),
                    ),
                    Text(
                        "${_dateDif()}${dateSelected.year}/${dateSelected.month}/${dateSelected.day}"),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _keyboardButton(String iconName) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => _buttonAction(iconName),
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
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Theme.of(context).colorScheme.primary,
                  spreadRadius: -3,
                )
              ],
            ),
            child: Icon(
              getIcon(iconName),
              size: iconName == ',' || iconName == '.'
                  ? 12
                  : iconName == 'divider' ||
                          iconName == 'multiplication' ||
                          iconName == 'minus' ||
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
}
