import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/src/widgets/settings/picker_color_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';

class IconSelectorWidget extends StatefulWidget {
  final Function(Color, String) confirm;
  final Color? defaultColor;
  final String? defaultIcon;
  const IconSelectorWidget({
    super.key,
    required this.confirm,
    this.defaultColor,
    this.defaultIcon,
  });

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  late TextEditingController _iconController;
  late String iconSelected;
  late Color colorSelected;
  late String iconCategory;
  late Color colorCategory;

  final List<String> _accountsIcons = [
    "bank",
    "cash",
    "cashMultiple",
    "cash100",
    "creditCardOutline",
    "fileOutline",
    "giftOutline",
    "piggyBankOutline",
    "simOutline",
    "walletBifoldOutline",
    "walletGiftCard",
    "walletMembership",
    "walletOutline",
  ];

  @override
  void initState() {
    _iconController = TextEditingController(text: " ");
    iconCategory = widget.defaultIcon ?? "none";
    colorCategory = widget.defaultColor ??
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    super.initState();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
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
              fillColor: colorCategory.withAlpha(50),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _openChangeIcon,
              child: Icon(
                getIcon(iconCategory),
                color: colorCategory.withAlpha(255),
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  StatefulBuilder _dialogIcon(BuildContext context) {
    String iconCategoryTemp = iconCategory;
    Color colorCategoryTemp = colorCategory;
    return StatefulBuilder(builder: (localContext, localSetState) {
      void changeIcon(String newIcon) {
        localSetState(() {
          iconCategoryTemp = newIcon;
        });
      }

      void openIconSelector() {
        showDialog(
          context: context,
          builder: (context) => _dialogIconSelector(
            context,
            localSetState,
            iconCategoryTemp,
            changeIcon,
          ),
        );
      }

      void changeColorAndIcon() {
        setState(() {
          iconCategory = iconCategoryTemp;
          colorCategory = colorCategoryTemp;
        });
        Navigator.of(localContext).pop();
        widget.confirm(colorCategory, iconCategory);
      }

      void changeColor(Color newColor) {
        localSetState(() {
          colorCategoryTemp = newColor;
        });
      }

      return OrientationBuilder(builder: (context, orientation) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                _iconPreview(iconCategoryTemp, colorCategoryTemp),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onPressed: openIconSelector,
                      icon: getIcon("search"),
                      text: S.current.selectIcon,
                      type: ButtonType.selector,
                    ),
                    PickerColorSelectorWidget(
                      type: ButtonType.selector,
                      color: colorCategoryTemp,
                      confirm: changeColor,
                      icon: getIcon("palette"),
                      text: S.current.selectColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(localContext).pop,
              child: Text(S.current.cancel),
            ),
            TextButton(
              onPressed: changeColorAndIcon,
              child: Text(S.current.confirm),
            ),
          ],
        );
      });
    });
  }

  Container _iconPreview(String icon, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withAlpha(50),
      ),
      child: Icon(getIcon(icon), color: color, size: 35),
    );
  }

  AlertDialog _dialogIconSelector(
    BuildContext context,
    StateSetter changeState,
    String iconSelected,
    Function(String) changeIcon,
  ) {
    return AlertDialog(
      title: Text(S.current.icons),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _title(S.current.accounts),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: _accountsIcons
                    .map((icon) => _iconButton(icon, iconSelected, changeIcon))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _title(String text) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        "$text.",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _iconButton(
    String iconName,
    String iconSelected,
    Function(String) action,
  ) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          action(iconName);
        },
        icon: Icon(
          getIcon(iconName),
          color: iconName == iconSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onBackground,
          size: 35,
        ));
  }
}
