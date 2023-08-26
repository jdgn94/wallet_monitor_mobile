import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/models/account_summary.model.dart';
import 'package:wallet_monitor/src/db/queries/account.consult.dart';
import 'package:wallet_monitor/src/db/models/navigator_returned.dart';
import 'package:wallet_monitor/src/functions/currency.function.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/storage/index.dart';

class AccountPage extends StatefulWidget {
  final SharedPreferences pref;
  const AccountPage({super.key, required this.pref});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Account?> accounts = [];
  List<SummaryAccount?> summaryAccounts = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _getAllAccountsAndSummary();
    _getResumenByPrimaryAccount();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getAllAccountsAndSummary() async {
    final response = await AccountConsult.getAll();
    final summaryAccount = await AccountConsult.getSummaryByCurrency(
        widget.pref.getInt("defaultCurrency") ?? 103);

    List<SummaryAccount?> tempSummary = response.summaryAccounts;
    tempSummary.add(summaryAccount);
    setState(() {
      accounts = response.accounts;
      summaryAccounts = tempSummary;
    });
  }

  Future<void> _getResumenByPrimaryAccount() async {}

  Future<void> _goToCreateAccount() async {
    final CreateReturner? response =
        await Navigator.of(context).pushNamed("/account");
    if (response == null) return;
    if (response.reload) {
      _getAllAccountsAndSummary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _accountViewSelector(),
        const SizedBox(height: 7),
        _accountViewPages(),
      ],
    );
  }

  Container _accountViewSelector() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.all(10),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Theme.of(context).colorScheme.onBackground,
          splashBorderRadius: BorderRadius.circular(10),
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: [
            _tab(S.current.accounts),
            _tab(S.current.summary),
          ],
        ),
      ),
    );
  }

  Tab _tab(String text) {
    return Tab(
      height: 50,
      child: Text(text),
    );
  }

  Expanded _accountViewPages() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Wrap(
              children: [
                _listAccounts(),
                _addAccount(),
              ],
            ),
          ),
          _listSummary(),
        ],
      ),
    );
  }

  Column _listAccounts() {
    return Column(
      children: accounts.map((item) => _listItem(item!)).toList(),
    );
  }

  Padding _listItem(Account item) {
    final buttonSplash = Color(int.parse("0x${item.color}")).withAlpha(30);
    final buttonColor = Color(int.parse("0x${item.color}")).withAlpha(50);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        splashColor: buttonSplash,
        highlightColor: buttonSplash,
        hoverColor: buttonSplash,
        focusColor: buttonSplash,
        child: Ink(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Ink(
                height: double.infinity,
                width: 70,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    getIcon(item.icon),
                    color: Color(int.parse("0x${item.color}")),
                    size: 45,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        CurrencyFunctions.formatNumber(
                          symbol: item.currencySymbol,
                          decimalDigits: item.decimalDigits,
                          amount: item.amount,
                        ),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _addAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
      child: DottedBorder(
        color: Theme.of(context).colorScheme.onBackground.withAlpha(150),
        strokeWidth: 1,
        borderType: BorderType.RRect,
        padding: EdgeInsets.zero,
        radius: const Radius.circular(10.0),
        child: InkWell(
          onTap: _goToCreateAccount,
          borderRadius: BorderRadius.circular(10.0),
          child: Ink(
            width: double.infinity,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(getIcon("add"), size: 30),
                const SizedBox(width: 10),
                Text(
                  S.current.createAccount,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _listSummary() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children:
              summaryAccounts.map((item) => _summaryItems(item!)).toList(),
        ),
      ),
    );
  }

  Widget _summaryItems(SummaryAccount summary) {
    final lastItem =
        summaryAccounts.indexOf(summary) == summaryAccounts.length - 1;

    return Wrap(
      children: [
        Visibility(
          visible: lastItem,
          child: Divider(color: Theme.of(context).colorScheme.primary),
        ),
        Container(
          width: double.infinity,
          height: 115,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CurrencyFunctions.name(summary.currencyName),
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              Divider(color: Theme.of(context).colorScheme.primary),
              _totalsItems(
                S.current.totalAccounts,
                summary.totalAccounts.toString(),
              ),
              _totalsItems(
                S.current.totalAmount,
                CurrencyFunctions.formatNumber(
                  symbol: summary.currencySymbol,
                  decimalDigits: summary.decimalDigits,
                  amount: summary.totalAmounts,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _totalsItems(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
