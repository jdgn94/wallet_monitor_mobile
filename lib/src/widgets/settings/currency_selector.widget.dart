// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/bloc/settings/settings_bloc.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';
import 'package:wallet_monitor/src/functions/snack_bar.function.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class CurrencySelectorWidget extends StatefulWidget {
  final SharedPreferences pref;
  final bool disabled;
  final bool localSelect;
  final int? defaultCurrency;
  final Function(Currency)? confirm;

  const CurrencySelectorWidget({
    super.key,
    required this.pref,
    this.localSelect = false,
    this.defaultCurrency,
    this.confirm,
    this.disabled = false,
  });

  @override
  State<CurrencySelectorWidget> createState() => _CurrencySelectorWidgetState();
}

class _CurrencySelectorWidgetState extends State<CurrencySelectorWidget> {
  late TextEditingController _inputController;
  late int currency;
  late List<Currency> currencies;

  @override
  void initState() {
    currency =
        widget.pref.getInt('defaultCurrency') ?? widget.defaultCurrency ?? 103;
    _inputController = TextEditingController();
    _setInputName();
    _getAllCurrencies();
    if (widget.pref.getInt('defaultCurrency') == null) {
      _changeCurrencyPref(103);
    } else {
      _changeCurrencyPref(widget.pref.getInt('defaultCurrency')!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _changeCurrencyPref(int newCurrencyId) async {
    final newCurrency = await CurrencyConsult.getById(newCurrencyId);
    if (newCurrency == null) return;
    print("Cambiando los valores de los prefs por ${newCurrency.name}");
    print("id de la nueva moneda $newCurrencyId");

    if (widget.localSelect) {
      widget.confirm!(newCurrency);
    } else {
      BlocProvider.of<SettingsBloc>(context).add(ChangeDefaultCurrency(
        newCurrencyId,
        newCurrency.symbol,
      ));
    }
  }

  void _openSelector() {
    if (widget.disabled) {
      showMessage(
        context: context,
        type: Type.warning,
        message: S.current.currencyNotChange,
      );
      return;
    }
    showDialog(context: context, builder: _dialog);
  }

  Future<void> _getAllCurrencies() async {
    currencies = await CurrencyConsult.getAll();
    setState(() {});
  }

  Future<void> _setInputName() async {
    final currencyValue = await CurrencyConsult.getById(currency);
    if (currencyValue == null) {
      _inputController.text = S.current.none;
      return;
    }
    _inputController.text =
        "${currencyValue.symbol} ${CurrencyFunctions.name(currencyValue.name)}";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.localSelect) {
      return _selector();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.currency, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            _selector(),
          ],
        ),
      ),
    );
  }

  TextField _selector() {
    return TextField(
      controller: _inputController,
      readOnly: true,
      onTap: _openSelector,
      decoration: InputDecoration(
        label:
            Text(widget.localSelect ? S.current.currency : S.current.primary),
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  StatefulBuilder _dialog(BuildContext context) {
    int currencySelected = currency;

    return StatefulBuilder(builder: (localContext, localSetState) {
      void changeValue(int value) {
        localSetState(() {
          currencySelected = value;
        });
      }

      void confirm() {
        setState(() {
          currency = currencySelected;
        });
        _setInputName();
        _changeCurrencyPref(currencySelected);
        Navigator.of(localContext).pop();
      }

      return AlertDialog(
        title: Text(S.current.currencies),
        content: SizedBox(
          height: 500,
          width: 500,
          child: Column(
            children: [
              Visibility(
                visible: false, // MediaQuery.of(context).size.height > 500,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    label: Text(S.current.search),
                    border: const UnderlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: currencies
                        .map((currency) => _currencyItem(
                              currency,
                              currencySelected,
                              changeValue,
                            ))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          CustomButton(
            onPressed: Navigator.of(localContext).pop,
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

  RadioListTile _currencyItem(
    Currency currency,
    int selected,
    Function(int) changeValue,
  ) {
    return RadioListTile<int>(
      groupValue: selected,
      value: currency.id,
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      onChanged: (value) => changeValue(value!),
      title: Row(
        children: [
          Container(
            width: 40,
            margin: const EdgeInsets.only(right: 3),
            child: Text(currency.symbol),
          ),
          Expanded(
            child: Text(
              CurrencyFunctions.name(currency.name),
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          )
        ],
      ),
    );
  }
}
