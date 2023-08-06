import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/db/consults/account.consult.dart';
import 'package:wallet_monitor/src/utils/icons.utils.dart';
import 'package:wallet_monitor/storage/index.dart';

class AccountPage extends StatefulWidget {
  final SharedPreferences pref;
  const AccountPage({super.key, required this.pref});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Account?> accounts = [];

  @override
  void initState() {
    _getAllAccounts();
    super.initState();
  }

  Future<void> _getAllAccounts() async {
    accounts = await AccountConsult.getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7),
          _list(accounts),
          _addAccount(),
        ],
      ),
    );
  }

  Column _list(List<Account?> list) {
    return Column(
      children: list.map((item) => _listItem(item!)).toList(),
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
          height: 80,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Ink(
                height: double.infinity,
                width: 80,
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
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${item.currency.value!.symbol}\t${NumberFormat("#,##0.00", widget.pref.getString("formatNumber")!).format(item.amount)}",
                        style: const TextStyle(fontSize: 15),
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
          onTap: () => Navigator.pushNamed(context, "/account"),
          borderRadius: BorderRadius.circular(10.0),
          child: Ink(
            width: double.infinity,
            height: 80,
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
}
