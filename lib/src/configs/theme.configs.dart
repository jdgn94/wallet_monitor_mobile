import "package:flutter/material.dart";

class ColorDescription {
  final Color color;
  final String name;

  ColorDescription({required this.color, required this.name});
}

List<ColorDescription> colorsList = [
  ColorDescription(color: Colors.teal, name: 'teal'),
  ColorDescription(color: Colors.orange, name: 'orange'),
  ColorDescription(color: Colors.purple, name: 'purple'),
  ColorDescription(color: Colors.red, name: 'red'),
  ColorDescription(color: Colors.pink.shade300, name: 'pink'),
  ColorDescription(color: Colors.green.shade700, name: 'green'),
  ColorDescription(color: Colors.blue, name: 'blue'),
  ColorDescription(color: Colors.blue, name: 'chameleon'),
];

ThemeData themeLight({required String colorSelected}) {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: _getPrimaryColor(colorSelected),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(
            _getPrimaryColor(colorSelected).withAlpha(100)),
        // color
      ),
    ),
    useMaterial3: true,
  );
}

ThemeData themeDark({required String colorSelected}) {
  return ThemeData(
    colorScheme: ColorScheme.dark(
      primary: _getPrimaryColor(colorSelected),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(
            _getPrimaryColor(colorSelected).withAlpha(100)),
        // color
      ),
    ),
    useMaterial3: true,
  );
}

Color _getPrimaryColor(String value) {
  if (value[0] == "0" && value.length > 1 && value[1] == "x") {
    return Color(int.parse(value));
  }
  final valueFormate = int.parse(value);
  if (valueFormate < 0 || valueFormate >= colorsList.length) {
    return colorsList.reversed.first.color;
  } else {
    return colorsList[valueFormate].color;
  }
}
