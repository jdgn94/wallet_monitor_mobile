// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/bloc/settings/settings_bloc.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widgets.dart';

class FormatSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;

  const FormatSelectorWidget({super.key, required this.pref});

  @override
  State<FormatSelectorWidget> createState() => _FormatSelectorWidgetState();
}

class _FormatSelectorWidgetState extends State<FormatSelectorWidget> {
  final double numberExample = 12345678.90;
  late TextEditingController _inputController;
  late String currencyFormat;
  late String currencySymbol;

  @override
  void initState() {
    currencyFormat = widget.pref.getString('formatNumber') ?? 'en_US';
    _inputController = TextEditingController();
    _setInputText();
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  _setInputText() {
    currencySymbol = widget.pref.getString("currencySymbol") ?? '\$';
    NumberFormat nFormat = NumberFormat("#,##0.00", currencyFormat);
    _inputController.text = "$currencySymbol ${nFormat.format(numberExample)}";
    setState(() {});
  }

  void changeCurrency(String newFormat) {
    setState(() {
      currencyFormat = newFormat;
    });

    NumberFormat nFormat = NumberFormat("#,##0.00", newFormat);
    _inputController =
        TextEditingController(text: "\$ ${nFormat.format(numberExample)}");

    BlocProvider.of<SettingsBloc>(context).add(ChangeFormatNumber(newFormat));
  }

  void _openSelector() {
    showDialog(context: context, builder: _dialog);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state.currencySymbol != currencySymbol) {
        Future.delayed(Duration.zero, _setInputText);
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.currencyFormat,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _selector(),
            ],
          ),
        ),
      );
    });
  }

  TextField _selector() {
    return TextField(
      controller: _inputController,
      readOnly: true,
      onTap: _openSelector,
      decoration: InputDecoration(
        label: Text(S.current.format),
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  StatefulBuilder _dialog(BuildContext context) {
    String currencyFormatSelected = currencyFormat;

    return StatefulBuilder(builder: (localContext, localSetState) {
      void confirm() {
        changeCurrency(currencyFormatSelected);
        Navigator.of(context).pop();
      }

      void changeCurrencyTemp(String value) {
        localSetState(() {
          currencyFormatSelected = value;
        });
      }

      return AlertDialog(
        title: Text(S.current.currencyFormat),
        content: _optionList(currencyFormatSelected, changeCurrencyTemp),
        actions: [
          CustomButton(
            onPressed: Navigator.of(context).pop,
            message: S.current.cancel,
            icon: Icons.close,
            color: Colors.red,
            type: ButtonType.outline,
            width: 20,
          ),
          CustomButton(
            onPressed: confirm,
            message: S.current.confirm,
            icon: Icons.check,
            color: Colors.blue,
            type: ButtonType.outline,
            width: 20,
          ),
        ],
      );
    });
  }

  SingleChildScrollView _optionList(
      String format, void Function(String) changeValue) {
    return SingleChildScrollView(
      child: Column(
        children: <RadioListTile<String>>[
          RadioListTile(
            title: Text(
              "$currencySymbol ${NumberFormat("#,##0.00", "pl_PL").format(numberExample)}",
            ),
            value: 'pl_PL',
            groupValue: format,
            onChanged: (String? value) => changeValue(value!),
          ),
          RadioListTile(
            title: Text(
              "$currencySymbol ${NumberFormat("#,##0.00", "en_US").format(numberExample)}",
            ),
            value: 'en_US',
            groupValue: format,
            onChanged: (String? value) => changeValue(value!),
          ),
          RadioListTile(
            title: Text(
              "$currencySymbol ${NumberFormat("#,##0.00", "de_DE").format(numberExample)}",
            ),
            value: 'de_DE',
            groupValue: format,
            onChanged: (String? value) => changeValue(value!),
          ),
          RadioListTile(
            title: Text(
              "$currencySymbol ${NumberFormat("#,##0.00", "it_CH").format(numberExample)}",
            ),
            value: 'it_CH',
            groupValue: format,
            onChanged: (String? value) => changeValue(value!),
          ),
        ],
      ),
    );
  }
}
