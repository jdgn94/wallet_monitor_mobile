// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/models/navigator_returned.dart';
import 'package:wallet_monitor/src/db/queries/category.consult.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/db/queries/subcategory.consult.dart';
import 'package:wallet_monitor/src/functions/snack_bar.function.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/icon_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/keyboard.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class _CategoryType {
  final bool value;
  final String text;

  const _CategoryType({
    required this.value,
    required this.text,
  });
}

class CategoryEditionPage extends StatefulWidget {
  const CategoryEditionPage({super.key});

  @override
  State<CategoryEditionPage> createState() => _CategoryEditionPageState();
}

class _CategoryEditionPageState extends State<CategoryEditionPage> {
  final _pref = SettingsLocalStorage.pref;
  final List<_CategoryType> categories = [
    _CategoryType(value: true, text: S.current.expenses),
    _CategoryType(value: false, text: S.current.incomes),
  ];

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _accountTypeController;
  late TextEditingController _subcategoryController;
  late int currencyId;
  late Category? category;
  List<Subcategory?> subcategories = [];
  bool expenses = true;
  bool currencyLoad = false;
  bool loading = false;
  bool editing = false;
  double maxAmount = 0;
  Currency currency = Currency(
    code: '',
    decimalDigits: 0,
    exchangeRate: 1,
    id: 0,
    name: '',
    symbol: '',
  );
  String iconCategory = 'none';
  String iconSubcategory = 'none';
  Color colorCategory =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(250);

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _accountTypeController = TextEditingController();
    _subcategoryController = TextEditingController();
    currencyId = _pref.getInt("defaultCurrency") ?? 103;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _accountTypeController.dispose();
    _subcategoryController.dispose();
    super.dispose();
  }

  void _getArguments() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    expenses = args["expenses"] as bool;
    category = args["category"] as Category?;

    _accountTypeController.text =
        expenses == true ? S.current.expenses : S.current.incomes;

    if (category != null) {
      _nameController.text = category!.name;
      _descriptionController.text = category!.description;
      _accountTypeController.text =
          category!.expenses == true ? S.current.expenses : S.current.incomes;
      subcategories = category!.subcategories;
      iconCategory = category!.icon;
      colorCategory = Color(int.parse("0x${category!.color}")).withAlpha(250);
      expenses = category!.expenses;
      editing = true;
    }
  }

  Future<void> _getCurrency() async {
    setState(() {
      loading = true;
    });
    currency = await CurrencyConsult.getById(currencyId);
    setState(() {
      currencyLoad = true;
      loading = false;
    });
  }

  void _changeLimitForMonth(double newValue) {
    setState(() {
      maxAmount = newValue;
    });
  }

  void _selectIcon(Color newColor, String newIcon) {
    setState(() {
      colorCategory = newColor;
      iconCategory = newIcon;
    });
  }

  void _openChangeAccountType() {
    showDialog(context: context, builder: _dialogAccountType);
  }

  void _openSubcategory(int? position) {
    showDialog(
      context: context,
      builder: (context) => _dialogSubcategory(context, position),
    );
  }

  void _disableSubcategory(int position) {
    subcategories[position]!.deletedAt =
        subcategories[position]!.deletedAt != null ? null : DateTime.now();

    setState(() {});
  }

  Future<void> _saveCategory() async {
    try {
      final categoryId = await CategoryConsult.createOrUpdate(
        id: category?.id,
        maxAmount: maxAmount,
        color: colorCategory
            .toString()
            .replaceAll('Color(0x', '')
            .replaceAll(")", ""),
        icon: iconCategory,
        name: _nameController.text,
        description: _descriptionController.text,
        expenses: expenses,
        createdAt: category?.createdAt ?? DateTime.now(),
      );

      if (subcategories.isNotEmpty) {
        final length = subcategories.length;
        for (int i = 0; i < length; i++) {
          await SubcategoryConsult.createOrUpdate(
            id: subcategories[i]!.id == 0 ? null : subcategories[i]!.id,
            name: subcategories[i]!.name,
            categoryId: categoryId,
            createdAt: subcategories[i]!.createdAt,
            deletedAt: subcategories[i]!.deletedAt,
          );
        }
      }

      final response = CreateReturner(reload: true);
      Navigator.of(context).pop(response);
    } catch (e) {
      showMessage(context: context, type: Type.error, message: e.toString());
    }
  }

  Future<void> _disableCategory() async {
    try {
      await CategoryConsult.createOrUpdate(
        id: category!.id,
        maxAmount: maxAmount,
        color: colorCategory
            .toString()
            .replaceAll('Color(0x', '')
            .replaceAll(")", ""),
        icon: iconCategory,
        name: _nameController.text,
        description: _descriptionController.text,
        expenses: expenses,
        createdAt: category!.createdAt,
        deletedAt: category!.deletedAt == null ? DateTime.now() : null,
      );
      final response = CreateReturner(reload: true);
      Navigator.of(context).pop(response);
    } catch (e) {
      showMessage(context: context, type: Type.error, message: e.toString());
    }
  }

  void _saveSubcategory(int? position) {
    if (position != null) {
      subcategories[position]!.name = _subcategoryController.text;
      subcategories[position]!.icon = iconSubcategory;
    } else {
      subcategories.add(
        Subcategory(
          id: 0,
          name: _subcategoryController.text,
          icon: iconSubcategory,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }

    setState(() {});
    print("viendo el total de las sub categorías: $subcategories");
    Navigator.of(context).pop();
  }

  bool _checkValues() {
    return _nameController.text.isEmpty || iconCategory == 'none';
  }

  @override
  Widget build(BuildContext context) {
    if (currencyLoad == false && loading == false) {
      _getArguments();
      _getCurrency();
    }

    return Scaffold(
      appBar: _appBar(),
      body: Visibility(
        visible: currencyLoad,
        replacement: const Center(child: CircularProgressIndicator()),
        child: _body(),
      ),
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
              IconSelectorWidget(
                confirm: _selectIcon,
                defaultColor: colorCategory,
                defaultIcon: iconCategory,
              ),
              _spacing(),
              _accountType(),
              _spacing(),
              KeyboardWidget(
                pref: _pref,
                type: KeyType.input,
                label: S.current.limitCredit,
                currency: currency,
                confirm: _changeLimitForMonth,
                activeCalendar: false,
              ),
              _spacing(),
              _categoryContainer(),
              _spacing(),
              if (editing) _buttonToDelete(),
              if (editing) _buttonToCancel(),
              _buttonToSave(),
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

  TextField _accountType() {
    return TextField(
      controller: _accountTypeController,
      readOnly: true,
      onTap: _openChangeAccountType,
      decoration: InputDecoration(
        label: Text(S.current.accountType),
        prefixIcon: Icon(getIcon(expenses ? "expenses" : "incomes")),
      ),
    );
  }

  StatefulBuilder _dialogAccountType(BuildContext context) {
    bool localSelected = expenses;
    return StatefulBuilder(builder: (localContext, localSetState) {
      void changeValue(bool newValue) {
        localSetState(() {
          localSelected = newValue;
        });
        setState(() {
          expenses = newValue;
          _accountTypeController.text =
              newValue ? S.current.expenses : S.current.incomes;
        });
        Navigator.of(localContext).pop();
      }

      return AlertDialog(
        title: Text(S.current.accountType),
        content: SizedBox(
          width: 270,
          child: Wrap(
            children: [
              _accountTypeItem(
                categories[0].value,
                localSelected,
                categories[0].text,
                changeValue,
              ),
              _accountTypeItem(
                categories[1].value,
                localSelected,
                categories[1].text,
                changeValue,
              ),
            ],
          ),
        ),
      );
    });
  }

  RadioListTile<bool> _accountTypeItem(
    bool typeValue,
    bool itemValue,
    String text,
    Function(bool) changeValue,
  ) {
    return RadioListTile<bool>(
      groupValue: itemValue,
      value: typeValue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      onChanged: (value) => changeValue(value!),
      title: Row(
        children: [
          Container(
            width: 40,
            margin: const EdgeInsets.only(right: 3),
            child: Icon(getIcon(typeValue ? "expenses" : "incomes")),
          ),
          Text(
            text,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget _categoryContainer() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 80,
        maxHeight: 320,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.onBackground),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(
              S.current.subcategories,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          const Divider(),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: subcategories
                  .map((item) => _subcategoryItems(item!))
                  .toList(),
            )),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _openSubcategory(null),
                child: Row(
                  children: [
                    Text(S.current.addSubcategory),
                    Icon(getIcon('add')),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _subcategoryItems(Subcategory subcategory) {
    editSubcategory() {
      final int position = subcategories.indexOf(subcategory);

      _openSubcategory(position);
    }

    deleteSubcategory() {
      final int position = subcategories.indexOf(subcategory);

      _disableSubcategory(position);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              subcategory.name,
              style: const TextStyle(fontSize: 17.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Row(
            children: [
              CustomButton(
                onPressed: editSubcategory,
                icon: getIcon("edit"),
                color: Colors.blue,
                type: ButtonType.text,
                size: 25,
                message: S.current.edit,
              ),
              CustomButton(
                onPressed: deleteSubcategory,
                icon: getIcon(
                  subcategory.deletedAt != null
                      ? "deleteItemOff"
                      : "deleteItem",
                ),
                color: Colors.red,
                type: ButtonType.text,
                size: 25,
                message: S.current.disable,
              ),
            ],
          ),
        ],
      ),
    );
  }

  StatefulBuilder _dialogSubcategory(BuildContext context, int? position) {
    if (position != null) {
      _subcategoryController.text = subcategories[position]!.name;
    } else {
      _subcategoryController.text = "";
    }

    return StatefulBuilder(builder: (localContext, localSetState) {
      String localIcon =
          position != null ? subcategories[position]!.icon : 'none';
      void selectIconSubcategory(_, String newIcon) {
        localSetState(() {
          localIcon = newIcon;
        });
        setState(() {
          iconSubcategory = newIcon;
        });
      }

      return AlertDialog(
        content: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconSelectorWidget(
              confirm: selectIconSubcategory,
              defaultColor: colorCategory,
              defaultIcon: localIcon,
              onlyIcon: true,
            ),
            const SizedBox(
              height: 15,
              width: double.infinity,
            ),
            TextField(
              controller: _subcategoryController,
              autofocus: true,
              onSubmitted: (_) => _saveSubcategory(position),
              decoration: InputDecoration(
                label: Text(S.current.subcategory),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(localContext).pop,
            child: Text(S.current.cancel),
          ),
          TextButton(
            onPressed: () => _saveSubcategory(position),
            child: Text(S.current.confirm),
          ),
        ],
      );
    });
  }

  CustomButton _buttonToDelete() {
    return CustomButton(
      onPressed: _disableCategory,
      type: ButtonType.text,
      margin: const EdgeInsets.only(bottom: 10.0),
      backgroundColor: category!.deletedAt == null
          ? Colors.red.withAlpha(50)
          : Colors.blue.withAlpha(50),
      color: category!.deletedAt == null ? Colors.red : Colors.blue,
      text: category!.deletedAt == null ? S.current.disable : S.current.enable,
      size: 20,
    );
  }

  CustomButton _buttonToCancel() {
    return CustomButton(
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.red,
      onPressed: Navigator.of(context).pop,
      text: S.current.cancel,
      type: ButtonType.outline,
      height: 50,
      size: 20,
    );
  }

  CustomButton _buttonToSave() {
    final usePrimaryColor = _pref.getString("color") == "7" ? false : true;
    return CustomButton(
      color: usePrimaryColor ? null : colorCategory,
      onPressed: _saveCategory,
      text: editing ? S.current.edit : S.current.create,
      height: 50,
      size: 20,
      disabled: _checkValues(),
    );
  }
}
