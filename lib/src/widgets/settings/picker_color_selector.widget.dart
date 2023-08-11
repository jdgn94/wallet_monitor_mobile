import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wallet_monitor/generated/l10n.dart';

import 'package:wallet_monitor/src/widgets/utils/buttons.widget.dart';

class PickerColorSelectorWidget extends StatefulWidget {
  final ButtonType type;
  final Color color;
  final Function(Color) confirm;
  final IconData? icon;
  final String? text;
  final double? width;

  const PickerColorSelectorWidget({
    super.key,
    required this.type,
    required this.color,
    required this.confirm,
    this.icon,
    this.text,
    this.width,
  });

  @override
  State<PickerColorSelectorWidget> createState() =>
      _PickerSelectorWidgetState();
}

class _PickerSelectorWidgetState extends State<PickerColorSelectorWidget> {
  Color currentColor = const Color(0xFF9e9e9e);

  void _changeCurrentColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  void _openPicker() {
    setState(() {
      currentColor = widget.color;
    });
    showDialog(context: context, builder: _picker);
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      type: widget.type,
      icon: widget.icon,
      text: widget.text,
      color: widget.color,
      width: widget.width,
      onPressed: _openPicker,
    );
  }

  StatefulBuilder _picker(BuildContext context) {
    confirm(Color newColor) {
      widget.confirm(newColor);
      Navigator.of(context).pop();
    }

    return StatefulBuilder(
      builder: (localContext, localSetState) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    orientation == Orientation.portrait ? 200 : 40,
                  ),
                  bottom: const Radius.circular(40),
                ),
              ),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: widget.color,
                  paletteType: orientation == Orientation.portrait
                      ? PaletteType.hueWheel
                      : PaletteType.hsl,
                  onColorChanged: _changeCurrentColor,
                  colorPickerWidth:
                      orientation == Orientation.portrait ? 300 : 200,
                  enableAlpha: false,
                ),
              ),
              actions: <Widget>[
                CustomButton(
                  onPressed: Navigator.of(context).pop,
                  message: S.current.cancel,
                  icon: Icons.clear,
                  color: Colors.red,
                  type: ButtonType.outline,
                  width: 20,
                ),
                CustomButton(
                  onPressed: () => confirm(currentColor),
                  message: S.current.confirm,
                  icon: Icons.check,
                  color: Colors.blue,
                  type: ButtonType.outline,
                  width: 20,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
