import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/bloc/settings/settings_bloc.dart';
import 'package:wallet_monitor/src/configs/theme.configs.dart';
import 'package:wallet_monitor/src/widgets/settings/picker_color_selector.widget.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';
import 'package:wallet_monitor/storage/index.dart';

class ColorSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;

  const ColorSelectorWidget({super.key, required this.pref});

  @override
  State<ColorSelectorWidget> createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  late TextEditingController _inputController;
  String? colorSelector;
  int? colorIndexSelector;
  Color pickerColor = const Color(0xFF9e9e9e);

  @override
  void initState() {
    _inputController = TextEditingController();
    if (widget.pref.getString("color") == null) {
      colorSelector = S.current.teal;
      colorIndexSelector = 0;
    } else if (widget.pref.getString("color")![0] == '0' &&
        widget.pref.getString("color")!.length > 1 &&
        widget.pref.getString("color")![1] == "x") {
      colorSelector = S.current.personal;
      pickerColor = Color(int.parse(widget.pref.getString("color")!));
    } else {
      colorIndexSelector = int.parse(widget.pref.getString("color")!);
      colorSelector = colorsList[colorIndexSelector!].name;
    }

    _inputController.text = _colorNameTranslate(colorSelector!);
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _openSelector() {
    showDialog(context: context, builder: _dialog);
  }

  void _changeGlobalColor(int? colorIndex, String colorName) {
    BlocProvider.of<SettingsBloc>(context).add(ChangeColor(
      (colorIndex ?? pickerColor)
          .toString()
          .replaceAll("Color(", "")
          .replaceAll(")", ""),
    ));
    _inputController.text = _colorNameTranslate(colorName);
    setState(() {
      colorIndexSelector = colorIndex;
      colorSelector = colorName;
    });
  }

  void _changePickerColor(Color color) {
    setState(() {
      pickerColor = color;
      colorIndexSelector = null;
      colorSelector = 'Personal';
    });
  }

  String _colorNameTranslate(String name) {
    switch (name) {
      case 'teal':
        return S.current.teal;
      case 'purple':
        return S.current.purple;
      case 'pink':
        return S.current.pink;
      case 'blue':
        return S.current.blue;
      case 'orange':
        return S.current.orange;
      case 'red':
        return S.current.red;
      case 'green':
        return S.current.green;
      case 'chameleon':
        return S.current.chameleon;
      default:
        return S.current.personal;
    }
  }

  @override
  Container build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.colorSelector, style: const TextStyle(fontSize: 22)),
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
        label: Text(S.current.color),
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  StatefulBuilder _dialog(BuildContext context) {
    String? colorSelectTemp = colorSelector;
    int? indexSelected = colorIndexSelector;

    return StatefulBuilder(
      builder: (localContext, localSetState) {
        void changeColorSelected(ColorDescription newColor) {
          localSetState(() {
            colorSelectTemp = newColor.name;
            indexSelected = colorsList.indexOf(newColor);
          });
        }

        void confirm() {
          Navigator.of(localContext).pop();
          _changeGlobalColor(indexSelected, colorSelectTemp!);
        }

        void changePersonalColor(Color color) {
          localSetState(() {
            colorSelectTemp = "Personal";
            indexSelected = null;
          });
          _changePickerColor(color);
        }

        return AlertDialog(
          title: Text(S.current.selectAColor),
          content: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: colorsList
                        .map(
                          (e) => _colorButton(
                            changeColorSelected,
                            e,
                            colorSelectTemp,
                            context,
                          ),
                        )
                        .toList(),
                  ),
                  _personalColor(colorSelectTemp, changePersonalColor),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(localContext).pop,
              child: Text(S.current.cancel),
            ),
            TextButton(
              onPressed: confirm,
              child: Text(S.current.confirm),
            ),
          ],
        );
      },
    );
  }

  Padding _colorButton(
    Function(ColorDescription newColor) changeColorSelected,
    ColorDescription element,
    String? colorSelectTemp,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomButton(
        onPressed: () => changeColorSelected(element),
        color: element.name == 'chameleon' ? Colors.grey : element.color,
        icon: element.name == 'chameleon'
            ? Icons.colorize_rounded
            : Icons.format_color_fill_rounded,
        text: _colorNameTranslate(element.name),
        selected: colorSelectTemp == element.name,
        width: MediaQuery.of(context).size.width / 3 - 10,
        type: ButtonType.color,
      ),
    );
  }

  Padding _personalColor(
    String? colorSelectorTmp,
    Function(Color) changeColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: PickerColorSelectorWidget(
        color: pickerColor,
        type: ButtonType.color,
        icon: Icons.palette_rounded,
        text: S.current.personal,
        width: MediaQuery.of(context).size.width / 3 * 2 - 10,
        confirm: (Color newColor) {
          changeColor(newColor);
          _changePickerColor(newColor);
        },
      ),
    );
  }
}
