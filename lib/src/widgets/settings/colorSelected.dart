import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_monitor/src/bloc/settings/settings_bloc.dart';
import 'package:wallet_monitor/src/configs/theme.dart';
import 'package:wallet_monitor/src/widgets/utils/buttons.dart';
import 'package:wallet_monitor/storage/index.dart';

class ColorSelector extends StatefulWidget {
  final SharedPreferences pref;

  const ColorSelector({super.key, required this.pref});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late TextEditingController _inputController;
  late String? colorSelector;
  late int? colorIndexSelector;

  @override
  void initState() {
    if (widget.pref.getString("color") == null) {
      colorSelector = 'None';
    } else if (widget.pref.getString("color")![0] == '#') {
      colorSelector = 'Personal';
    } else {
      colorIndexSelector = int.parse(widget.pref.getString("color")!);
      colorSelector = colorsList[colorIndexSelector!].name;
    }
    _inputController = TextEditingController(text: colorSelector);
    super.initState();
  }

  void _openSelector() {
    showDialog(context: context, builder: _dialog);
  }

  void _changeGlobalColor(int colorIndex, String colorName) {
    BlocProvider.of<SettingsBloc>(context)
        .add(ChangeColor(colorIndex.toString()));
    _inputController.text = colorName;
    setState(() {
      colorIndexSelector = colorIndex;
      colorSelector = colorName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Seleccione el color"),
            const SizedBox(height: 10),
            _selector(),
          ],
        ),
      ),
    );
  }

  Widget _selector() {
    return TextField(
      controller: _inputController,
      readOnly: true,
      onTap: _openSelector,
      decoration: const InputDecoration(
        label: Text("Color"),
        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  Widget _dialog(BuildContext context) {
    String? colorSelectTemp = colorSelector;
    int? indexSelected;

    return StatefulBuilder(
      builder: (localContext, localSetState) {
        void changeColorSelected(ColorDescription newColor) {
          localSetState(() {
            colorSelectTemp = newColor.name;
            indexSelected = colorsList.indexOf(newColor);
          });
        }

        void confirm() {
          Navigator.of(context).pop();
          _changeGlobalColor(indexSelected!, colorSelectTemp!);
        }

        return AlertDialog(
          title: const Text("Select Color"),
          content: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: colorsList
                        .map((color) => _colorContainer(
                              color,
                              colorSelectTemp,
                              changeColorSelected,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CustomButton(
              onPressed: Navigator.of(context).pop,
              message: "Cancelar",
              icon: Icons.close,
              color: Colors.red,
              type: ButtonType.outline,
              width: 20,
            ),
            CustomButton(
              onPressed: confirm,
              message: "Confirmar",
              icon: Icons.check,
              color: Colors.blue,
              type: ButtonType.outline,
              width: 20,
              disabled: indexSelected == null,
            ),
          ],
        );
      },
    );
  }

  Widget _colorContainer(
    ColorDescription color,
    String? colorSelect,
    Function(ColorDescription) changeColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => changeColor(color),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          width: MediaQuery.of(context).size.width / 3 - 10,
          height: 40.0,
          decoration: BoxDecoration(
            color: color.color.withAlpha(colorSelect == color.name ? 90 : 30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Ink(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.color.withAlpha(70),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Icon(Icons.palette, color: color.color),
              ),
              const SizedBox(width: 5.0),
              Text(color.name)
            ],
          ),
        ),
      ),
    );
  }
}
