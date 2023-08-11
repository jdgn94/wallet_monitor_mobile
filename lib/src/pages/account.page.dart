import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/consults/currency.consult.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/keyboard.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _pref = SettingsLocalStorage.pref;

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _iconController;
  late TextEditingController _amountController;
  late TextEditingController _alertController;
  late TextEditingController _currencyController;
  late int currencyId;
  late String iconSelected;
  late Color colorSelected;
  late Color colorPicker;
  Currency? currency;
  String iconCategory = 'none';
  Color colorCategory = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _iconController = TextEditingController(text: " ");
    _currencyController = TextEditingController();
    _amountController = TextEditingController();
    _alertController = TextEditingController();
    currencyId = _pref.getInt("defaultCurrency") ?? 103;
    _getCurrency();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    _amountController.dispose();
    _alertController.dispose();
    super.dispose();
  }

  Future<void> _getCurrency() async {
    currency = await CurrencyConsult.getById(currencyId);
    setState(() {});
  }

  void _openChangeIcon() {
    setState(() {
      iconSelected = iconCategory;
      colorSelected = colorCategory;
    });
    showDialog(context: context, builder: _dialogIcon);
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
        foregroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.onPrimary : null,
        backgroundColor: usePrimaryColor
            ? Theme.of(context).colorScheme.primary
            : colorCategory.withAlpha(255),
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
              _iconInput(),
              _spacing(),
              _currencyInput(),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.amount,
                currency: currency,
                confirm: (int value) {},
                activeCalendar: false,
              ),
              _spacing(),
              _alertInput(),
              _spacing(),
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

  Widget _iconInput() {
    return SizedBox(
      height: 64,
      child: Stack(
        children: [
          TextField(
            controller: _iconController,
            readOnly: true,
            onTap: _openChangeIcon,
            decoration: InputDecoration(
              label: Text(S.current.icon),
              filled: true,
              fillColor: colorCategory.withAlpha(100),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _openChangeIcon,
              child: Icon(
                getIcon(iconCategory),
                color: colorCategory.withAlpha(255),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _currencyInput() {
    return TextField(
      controller: _currencyController,
      readOnly: true,
      decoration: InputDecoration(
        label: Text(S.current.currency),
        prefixIcon: const Icon(Icons.search_rounded),
      ),
    );
  }

  Widget _alertInput() {
    return TextField(
      controller: _alertController,
      readOnly: true,
      decoration: InputDecoration(
        label: Text(S.current.minimumAmount),
      ),
    );
  }

  StatefulBuilder _dialogIcon(BuildContext context) {
    return StatefulBuilder(builder: (localContext, localSetState) {
      void changeColorAndIcon() {
        Navigator.of(localContext).pop();
      }

      return OrientationBuilder(builder: (context, orientation) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                _iconPreview(),
                _spacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _selector("Select Icon", "search"),
                    _selector("Select Color", "palette"),
                  ],
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
              onPressed: changeColorAndIcon,
              message: S.current.confirm,
              icon: Icons.check,
              color: Colors.blue,
              type: ButtonType.outline,
              width: 20,
              disabled: iconSelected == "none",
            ),
          ],
        );
      });
    });
  }

  Container _iconPreview() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorSelected.withAlpha(100),
      ),
      child: Icon(
        getIcon(iconSelected),
        color: colorSelected.withAlpha(255),
      ),
    );
  }

  InkWell _selector(String text, String icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: Ink(
        width: MediaQuery.of(context).size.width / 2 - 70,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Icon(getIcon(icon)),
            const SizedBox(height: 10.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}
