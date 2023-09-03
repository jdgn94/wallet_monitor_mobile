import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';
import 'package:wallet_monitor/src/db/queries/category.consult.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';
import 'package:wallet_monitor/src/widgets/utils/keyboard.widget.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  final SharedPreferences pref;
  Currency currency;

  CategoryPage({super.key, required this.pref, required this.currency});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Category?> categoriesExpenses = [];
  List<Category?> categoriesIncomes = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getCategories();
    super.initState();
  }

  Future<void> _getCategories() async {
    categoriesExpenses = await CategoryConsult.getAll(expenses: true);
    categoriesIncomes = await CategoryConsult.getAll(expenses: false);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _categoryType(),
        const SizedBox(height: 10.0),
        Expanded(child: _categoryPages()),
      ],
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
          controller: _tabController,
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
            _tab(S.current.expenses, 200, Colors.red),
            _tab(S.current.incomes, 1050, Colors.green),
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

  Padding _categoryPages() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: TabBarView(
        controller: _tabController,
        children: [
          _categoryExpenses(),
          const Text("ingresps"),
        ],
      ),
    );
  }

  Center _categoryExpenses() {
    return Center(
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            children: categoriesExpenses
                .map(
                  (item) => KeyboardWidget(
                    confirm: (_) {},
                    pref: widget.pref,
                    type: KeyType.buttonCategory,
                    category: item!,
                    currency: widget.currency,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
