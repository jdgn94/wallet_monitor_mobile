import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_monitor/generated/l10n.dart';
import 'package:wallet_monitor/src/functions/utils.functions.dart';

enum DateType { month, day, year, range }

class CalendarSelectorWidget extends StatefulWidget {
  const CalendarSelectorWidget({super.key});

  @override
  State<CalendarSelectorWidget> createState() => _CalendarSelectorWidgetState();
}

class _CalendarSelectorWidgetState extends State<CalendarSelectorWidget> {
  DateType dateType = DateType.month;
  DateTime firstCurrentDate = DateTime.now();
  DateTime? lastCurrentDate;

  void _substractNumber() {
    final newFirstCurrentDate =
        DateTime(firstCurrentDate.year, firstCurrentDate.month - 1);
    setState(() {
      firstCurrentDate = newFirstCurrentDate;
    });
  }

  void _addMonth() {
    final newFirstCurrentDate =
        DateTime(firstCurrentDate.year, firstCurrentDate.month + 1);
    setState(() {
      firstCurrentDate = newFirstCurrentDate;
    });
  }

  void _openDialogSelectMonth() {
    showDialog(context: context, builder: _dialogDate);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buttonPassMonth(),
          _actualMonth(),
          _buttonNextMonth(),
        ],
      ),
    );
  }

  Widget _buttonPassMonth() {
    return IconButton(
      onPressed: _substractNumber,
      icon: const Icon(Icons.chevron_left_rounded),
    );
  }

  Widget _actualMonth() {
    return Expanded(
      child: GestureDetector(
        child: InkWell(
          onTap: _openDialogSelectMonth,
          focusColor: Theme.of(context).colorScheme.primary.withAlpha(100),
          hoverColor: Theme.of(context).colorScheme.primary.withAlpha(100),
          splashColor: Theme.of(context).colorScheme.primary.withAlpha(100),
          highlightColor: Theme.of(context).colorScheme.primary.withAlpha(100),
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: const EdgeInsets.all(7),
            child: Text(
              "${translateMonth(firstCurrentDate.month)} ${firstCurrentDate.year}",
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonNextMonth() {
    return IconButton(
      onPressed: _addMonth,
      icon: const Icon(Icons.chevron_right_rounded),
    );
  }

  StatefulBuilder _dialogDate(BuildContext context) {
    return StatefulBuilder(builder: (localContext, localSetState) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: SizedBox(
            width: 250,
            child: Wrap(
              spacing: 5,
              alignment: WrapAlignment.center,
              children: [
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_range.svg",
                  text: S.current.selectRange,
                  width: 245,
                  topLeft: 20,
                  topRight: 20,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_infinity.svg",
                  text: S.current.allTime,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_year.svg",
                  text: S.current.selectYear,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_month.svg",
                  text: S.current.selectMonth,
                  bottomLeft: 20,
                ),
                _buttonBase(
                  asset: "lib/src/assets/icons/calendar_today.svg",
                  text: S.current.selectDay,
                  bottomRight: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buttonBase({
    required String asset,
    required String text,
    double? width,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: () {},
        child: Ink(
          width: width ?? 120.0,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft ?? 0),
                topRight: Radius.circular(topRight ?? 0),
                bottomLeft: Radius.circular(bottomLeft ?? 0),
                bottomRight: Radius.circular(bottomRight ?? 0),
              )),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SvgPicture.asset(asset, height: 55),
              const SizedBox(height: 10),
              Expanded(child: Text(text)),
            ],
          ),
        ),
      ),
    );
  }
}
