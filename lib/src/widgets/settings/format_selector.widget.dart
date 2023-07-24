import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormatSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;

  const FormatSelectorWidget({super.key, required this.pref});

  @override
  State<FormatSelectorWidget> createState() => _FormatSelectorWidgetState();
}

class _FormatSelectorWidgetState extends State<FormatSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
