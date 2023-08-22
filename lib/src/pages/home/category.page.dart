import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  final SharedPreferences pref;
  Currency currency;

  CategoryPage({super.key, required this.pref, required this.currency});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _categoryType(),
        ],
      ),
    );
  }

  Container _categoryType() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: TabBar(
          padding: const EdgeInsets.all(10),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Theme.of(context).colorScheme.onBackground,
          splashBorderRadius: BorderRadius.circular(10),
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: [
            _tab("expenses", 200, Colors.red),
            _tab("incomes", 1050, Colors.green),
          ],
        ),
      ),
    );
  }

  Tab _tab(String text, double value, Color numberColor) {
    return Tab(
      height: 50,
      child: Column(
        children: [
          Text(text),
          const SizedBox(height: 7),
          Text(
            CurrencyFunctions.formatNumber(
              amount: value,
              symbol: widget.pref.getString('currencySymbol')!,
              decimalDigits: widget.currency.decimalDigits,
            ),
            style: TextStyle(fontWeight: FontWeight.bold, color: numberColor),
          ),
        ],
      ),
    );
  }
}
