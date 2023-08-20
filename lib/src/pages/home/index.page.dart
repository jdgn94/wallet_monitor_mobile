import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/pages/home/accounts.page.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/storage/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pref = SettingsLocalStorage.pref;
  late PageController _pageController;
  int _page = 1;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  void _changePage(int newPage) {
    _pageController.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _page = newPage;
    });
  }

  String _pageName() {
    switch (_page) {
      case 0:
        return S.current.accounts;
      case 1:
        return S.current.categories;
      case 2:
        return S.current.operations;
      case 3:
        return S.current.statistics;
      default:
        return S.current.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      drawer: _drawer(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  PreferredSize _appBar() {
    final usePrimaryColor = _pref.getString("color") == "7" ? false : true;

    return PreferredSize(
      preferredSize: const Size(double.infinity, 50),
      child: AppBar(
        title: Text(_pageName()),
        centerTitle: true,
        foregroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.onPrimary : null,
        backgroundColor:
            usePrimaryColor ? Theme.of(context).colorScheme.primary : null,
        actions: [if (_page == 0 || _page == 1) _createButton()],
      ),
    );
  }

  IconButton _createButton() {
    return IconButton(
      onPressed: () => Navigator.of(context)
          .pushNamed(_page == 0 ? "/account" : "/category"),
      icon: Icon(getIcon("add")),
    );
  }

  PageView _body() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AccountPage(pref: _pref),
        const Center(child: Text("Page 1")),
        const Center(child: Text("Page 2")),
        const Center(child: Text("Page 3")),
      ],
    );
  }

  Drawer _drawer() {
    return Drawer(
      width: 350,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          SafeArea(
            child: Column(
              children: [
                _headerDrawer(),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _listPages(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _headerDrawer() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset('lib/src/assets/icons/logo.png'),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Text(
              'Wallet Monitor',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 27,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _listPages() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _listPageItem(getIcon("settings"), S.current.settings, "/settings"),
        ],
      ),
    );
  }

  InkWell _listPageItem(IconData iconName, String name, String routeName) {
    return InkWell(
      onTap: () => Navigator.of(context).popAndPushNamed(routeName),
      borderRadius: BorderRadius.circular(30.0),
      child: Ink(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(iconName),
              const SizedBox(width: 8.0),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      fixedColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.primary.withAlpha(175),
      currentIndex: _page,
      onTap: _changePage,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(getIcon('accounts')),
          icon: Icon(getIcon('noAccounts')),
          label: S.current.accounts,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(getIcon('categories')),
          icon: Icon(getIcon('noCategories')),
          label: S.current.categories,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(getIcon('operations')),
          icon: Icon(getIcon('noOperations')),
          label: S.current.operations,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(getIcon('statistics')),
          icon: Icon(getIcon('noStatistics')),
          label: S.current.statistics,
        ),
      ],
    );
  }
}
