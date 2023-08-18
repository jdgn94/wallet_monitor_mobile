import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectorWidget extends StatefulWidget {
  final SharedPreferences pref;

  const LanguageSelectorWidget({super.key, required this.pref});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
