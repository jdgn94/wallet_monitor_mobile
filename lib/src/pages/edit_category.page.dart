import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/models/navigator_returned.dart';
import 'package:wallet_monitor/src/db/queries/category.consult.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage>
    with SingleTickerProviderStateMixin {
  final _pref = SettingsLocalStorage.pref;
  late TabController _tabController;
  bool loadingCategoriesExpenses = true;
  bool loadingCategoriesIncomes = true;
  List<Category?> categoriesExpenses = [];
  List<Category?> categoriesIncomes = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getAllCategoriesExpenses();
    _getAllCategoriesIncomes();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getAllCategoriesExpenses() async {
    categoriesExpenses = await CategoryConsult.getAll(expenses: true);

    setState(() {
      loadingCategoriesExpenses = false;
    });
  }

  Future<void> _getAllCategoriesIncomes() async {
    categoriesIncomes = await CategoryConsult.getAll(expenses: false);

    setState(() {
      loadingCategoriesIncomes = false;
    });
  }

  Future<void> _editOrCreateCategory(
      {Category? category, required bool expenses}) async {
    final response =
        await Navigator.of(context).pushNamed("/category", arguments: {
      "category": category,
      "expenses": expenses,
    });

    if (response == null) return;
    final responseFormate = response as CreateReturner;
    if (responseFormate.reload) {
      _getAllCategoriesExpenses();
      _getAllCategoriesIncomes();
    }
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
        title: Text(S.current.categories),
        centerTitle: true,
        foregroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.onPrimary : null,
        backgroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }

  Column _body() {
    return Column(
      children: [
        _tabBar(),
        const SizedBox(height: 10.0),
        Expanded(child: _categoryPages()),
      ],
    );
  }

  Container _tabBar() {
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
            Tab(
              height: 50,
              child: Text(S.current.expenses),
            ),
            Tab(
              height: 50,
              child: Text(S.current.incomes),
            ),
          ],
        ),
      ),
    );
  }

  Padding _categoryPages() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: TabBarView(
        controller: _tabController,
        children: [
          _categoryList(categoriesExpenses, loadingCategoriesExpenses, true),
          _categoryList(categoriesIncomes, loadingCategoriesIncomes, false),
        ],
      ),
    );
  }

  Center _categoryList(
    List<Category?> categories,
    bool loading,
    bool expenses,
  ) {
    final width = (MediaQuery.of(context).size.width / 2 > 280
            ? (290 * (MediaQuery.of(context).size.width / 280).truncate())
            : (MediaQuery.of(context).size.width / 2 - 16)) -
        10;
    print("Ancho de la pantalla: por el cual multiplicar $width");

    List<Widget> listCategories = categories
        .map(
          (item) => CustomButton(
            onPressed: () =>
                _editOrCreateCategory(category: item, expenses: expenses),
            type: ButtonType.category,
            category: item!,
            showCategoryAmount: false,
            margin: const EdgeInsets.only(top: 10),
          ),
        )
        .toList();

    CustomButton addButton() {
      return CustomButton(
        onPressed: () => _editOrCreateCategory(expenses: expenses),
        type: ButtonType.dotted,
        icon: getIcon("add"),
        text: S.current.addCategory,
        maxWidth: 280,
        margin: const EdgeInsets.only(top: 10),
      );
    }

    listCategories.add(addButton());

    return Center(
      child: Visibility(
        visible: loading == false,
        replacement: const CircularProgressIndicator(),
        child: SizedBox(
          height: double.infinity,
          width: width.toDouble(),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              children: listCategories,
            ),
          ),
        ),
      ),
    );
  }
}
