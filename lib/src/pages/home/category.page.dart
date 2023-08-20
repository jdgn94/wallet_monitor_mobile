import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_monitor/src/widgets/utils/calendar_selector.widget.dart';

class CategoryPage extends StatefulWidget {
  final SharedPreferences pref;

  const CategoryPage({super.key, required this.pref});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CalendarSelectorWidget(),
        ],
      ),
    );
  }
}
