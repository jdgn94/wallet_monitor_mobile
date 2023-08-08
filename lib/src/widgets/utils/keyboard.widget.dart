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

  KeyboardWidget({
    super.key,
    required this.pref,
    required this.confirm,
    required this.type,
    this.currency,
    this.label,
    this.defaultValue,
  });

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  late TextEditingController _inputController;
  late String number;
  List<String> rightKeys = ["delete", "check"];
  List<String> leftKeys = [];

  @override
  void initState() {
    number = widget.defaultValue ?? '0';
    _inputController = TextEditingController();
    leftKeys = [
      "divider",
      "7",
      "8",
      "9",
      "multiplication",
      "4",
      "5",
      "6",
      "minus",
      "1",
      "2",
      "3",
      "sum",
      "0",
      widget.pref.getString("formatNumber") == "de_DE" ? "," : "."
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
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .80,
                    height: 400,
                    constraints: const BoxConstraints(
                      maxWidth: 490,
                    ),
                    padding:
                        const EdgeInsets.only(left: 7.0, top: 7.0, bottom: 7.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children:
                          leftKeys.map((e) => _keyboardButton(e)).toList(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .20,
                    height: 400,
                    padding: const EdgeInsets.only(
                        right: 7.0, top: 7.0, bottom: 7.0),
                    constraints: const BoxConstraints(
                      maxWidth: 130,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          rightKeys.map((e) => _keyboardButton(e)).toList(),
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

  Widget _keyboardButton(String iconName) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          final date = DateTime.parse("2023-08-08 09:13:37.205981");
          print(date);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: iconName == "0" ? 230 : 110,
            maxHeight: iconName == "check" || iconName == "equal" ? 295 : 85,
            minWidth: 52.8,
          ),
          child: Ink(
            width: MediaQuery.of(context).size.width *
                    .2 *
                    (iconName == '0' ? 2 : 1) -
                (iconName == '0' ? 20 : 15),
            height: iconName == "check" || iconName == "equal" ? 295 - 20 : 85,
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
            ),
          ),
        ),
      ),
    );
  }
}
