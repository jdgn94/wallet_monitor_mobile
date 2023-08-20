import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';

import 'package:wallet_monitor/storage/index.dart';

import '../widgets/utils/keyboard.widget.dart';

class CategoryEditionPage extends StatefulWidget {
  const CategoryEditionPage({super.key});

  @override
  State<CategoryEditionPage> createState() => _CategoryEditionPageState();
}

class _CategoryEditionPageState extends State<CategoryEditionPage> {
  final _pref = SettingsLocalStorage.pref;

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late int currencyId;
  double maxAmount = 0;
  Currency? currency;
  String iconCategory = 'none';
  Color colorCategory = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());

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

  void _changeLimitForMonth(double newValue) {
    setState(() {
      maxAmount = newValue;
    });
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
        title: Text(S.current.createCategory),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              _nameInput(),
              _spacing(),
              _descriptionInput(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.amount,
                currency: currency,
                confirm: _changeLimitForMonth,
                activeCalendar: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _nameInput() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        label: Text(S.current.name),
      ),
    );
  }

  SizedBox _spacing() {
    return const SizedBox(height: 40.0);
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
}
