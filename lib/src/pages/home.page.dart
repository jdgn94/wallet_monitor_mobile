import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_monitor/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;

  @override
  void initState() {
    super.initState();
  }

  void _changePage(int newPage) {
    setState(() {
      _page = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
    );
  }

  BottomNavigationBar _bottomBar() {
    return BottomNavigationBar(
      fixedColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.primary.withAlpha(175),
      currentIndex: _page,
      onTap: _changePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.walletBifold),
          label: S.current.accounts,
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.shapePlus),
          label: S.current.categories,
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.receiptText),
          label: S.current.operations,
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.chartBar),
          label: S.current.statistics,
        ),
      ],
    );
  }
}
